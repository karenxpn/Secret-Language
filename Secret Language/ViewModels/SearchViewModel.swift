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
    @Published var searchResults = [UserPreviewModel]()
    @Published var ideal: Int = 1
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var ideals = [ConnectionTypeModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SearchServiceProtocol
    var authDataManager: AuthServiceProtocol
    var userDataManager: UserServiceProtocol
    
    init(dataManager: SearchServiceProtocol = SearchService.shared,
         authDataManager: AuthServiceProtocol = AuthService.shared,
         userDataManager: UserServiceProtocol = UserService.shared) {
        self.dataManager = dataManager
        self.authDataManager = authDataManager
        self.userDataManager = userDataManager
        
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
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
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
                print(response)
            }.store(in: &cancellableSet)
    }
}
