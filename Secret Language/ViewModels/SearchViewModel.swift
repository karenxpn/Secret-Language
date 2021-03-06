//
//  SearchViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: AlertViewModel, ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "interestedInCategory" ) private var interestedInCategory: Int = 0
    @AppStorage( "genderPreference" ) private var genderPreference: Int = 0

    @Published var search: String = ""
    @Published var searchResults = [SearchUserViewModel]()
    @Published var ideal: Int = 1
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var ideals = [ConnectionTypeModel]()
    
    @Published var dataFilterGender: Int = 0
    @Published var dataFilterGenders = [GenderModel(id: 1, gender_name: "Male"),
                                        GenderModel(id: 2, gender_name: "Female"),
                                        GenderModel(id: 0, gender_name: "Everyone")]
    
    @Published var dataFilterCategories = [ConnectionTypeModel]()
    @Published var dataFilterCategory: Int = 0
    @Published var ageRange = 18...99
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SearchServiceProtocol
    var authDataManager: AuthServiceProtocol
    var userDataManager: UserServiceProtocol
    var profileDataManager: ProfileServiceProtocol
    var chatDataManager: ChatServiceProtocol
    
    init(dataManager: SearchServiceProtocol = SearchService.shared,
         authDataManager: AuthServiceProtocol = AuthService.shared,
         userDataManager: UserServiceProtocol = UserService.shared,
         profileDataManager: ProfileServiceProtocol = ProfileService.shared,
         chatDataManager: ChatServiceProtocol = ChatService.shared) {
        
        self.dataManager = dataManager
        self.authDataManager = authDataManager
        self.userDataManager = userDataManager
        self.profileDataManager = profileDataManager
        self.chatDataManager = chatDataManager
        super.init()
        
        self.ideal = self.interestedInCategory == 0 ? 1 : self.interestedInCategory
        
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
        dataManager.fetchSearchedUsers(token: token, searchText: search, idealFor: dataFilterCategory, gender: dataFilterGender, ageRange: ageRange)
            .sink { response in
                self.loading = false
                if response.error == nil {
                    self.searchResults = response.value!.map(SearchUserViewModel.init)
                }
            }.store(in: &cancellableSet)
    }
    
    func getPopularUsers() {
        loading = true
        dataManager.fetchPopularUsers(token: token, interestedIn: ideal)
            .sink { response in
                self.loading = false
                if response.error == nil {
                    self.searchResults = response.value!.map(SearchUserViewModel.init)
                }
            }.store(in: &cancellableSet)
    }
    
    func getIdealCategories() {
        loading = true
        authDataManager.fetchConnectionTypes()
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!,
                                   message: &self.alertMessage,
                                   alert: &self.showAlert)
                } else {
                    self.ideals = response.value!
                    self.dataFilterCategories =  [ConnectionTypeModel(id: 0, name: "Everyone", description: "")] + response.value!
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
    
    func sendGreetingMessage( userID: Int ) {
        chatDataManager.sendGreetingMessage(token: token, userID: userID, message: SendingMessageModel(type: "text", content: "????????"))
            .sink { _ in
            }.store(in: &cancellableSet)
    }
}
