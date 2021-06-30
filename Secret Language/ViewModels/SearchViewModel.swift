//
//  SearchViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @Published var search: String = ""
    @Published var searchResults = [SearchUserModel]()
    @Published var ideal: Int = 1
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var ideals = [ConnectionTypeModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SearchServiceProtocol
    var authDataManager: AuthServiceProtocol
    var userDataManager: UserServiceProtocol
    var profileDataManager: ProfileServiceProtocol
    
    init(dataManager: SearchServiceProtocol = SearchService.shared,
         authDataManager: AuthServiceProtocol = AuthService.shared,
         userDataManager: UserServiceProtocol = UserService.shared,
         profileDataManager: ProfileServiceProtocol = ProfileService.shared) {
        self.dataManager = dataManager
        self.authDataManager = authDataManager
        self.userDataManager = userDataManager
        self.profileDataManager = profileDataManager
        
        $search
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { (text) in
                if !text.isEmpty {
                    self.getSearchUsers(search: text)
                } else {
                    self.getPopularUsers()
                }
            }.store(in: &cancellableSet)
        
        $ideal
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { idealID in
                self.getPopularUsers()
            }.store(in: &cancellableSet)
    }
    
    func getSearchUsers(search: String) {
        loading = true
        dataManager.fetchSearchedUsers(token: token, searchText: search, idealFor: ideal)
            .sink { response in
                self.loading = false
                if response.error == nil {
                    self.searchResults = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getPopularUsers() {
        loading = true
        dataManager.fetchPopularUsers(token: token, interestedIn: ideal)
            .sink { response in
                self.loading = false
                if response.error == nil {
                    self.searchResults = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getIdealCategories() {
        loading = true
        authDataManager.fetchConnectionTypes()
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.alertMessage = response.error!.backendError == nil ? response.error!.initialError.localizedDescription : response.error!.backendError!.message
                    self.showAlert.toggle()
                } else {
                    self.ideals = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func connectUser( userID: Int ) {
        userDataManager.connectUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    if let updateIndex = self.searchResults.firstIndex(where: { $0.id == userID }) {
                        self.searchResults[updateIndex].friendStatus = 3
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func withdrawRequest( userID: Int ) {
        profileDataManager.withdrawFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    if let updateIndex = self.searchResults.firstIndex(where: { $0.id == userID }) {
                        self.searchResults[updateIndex].friendStatus = 1
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func acceptFriendRequest( userID: Int ) {
        profileDataManager.acceptFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    if let updateIndex = self.searchResults.firstIndex(where: { $0.id == userID }) {
                        self.searchResults[updateIndex].friendStatus = 2
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func rejectFriendRequest( userID: Int ) {
        profileDataManager.rejectFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    if let updateIndex = self.searchResults.firstIndex(where: { $0.id == userID }) {
                        self.searchResults[updateIndex].friendStatus = 1
                    }
                }
            }.store(in: &cancellableSet)
    }
}
