//
//  FriendsViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import Foundation
import Combine
import SwiftUI

class FriendsViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    
    @Published var searchText: String = ""
    @Published var friendsCount: Int = 22
    @Published var pendingCount: Int = 45
    @Published var requestsCount: Int = 3
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var friendsList = [UserPreviewModel]()
    @Published var requestsList = [UserPreviewModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: FriendsServiceProtocol
    
    init( dataManager: FriendsServiceProtocol = FriendsService.shared) {
        self.dataManager = dataManager
    }
    
    func getFriends() {
        loading = true
        dataManager.fetchFriends(token: token)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.friendsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getFriendRequests() {
        loading = true
        dataManager.fetchFriendRequests(token: token)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.requestsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getCounts() {
        loading = true

        dataManager.fetchFriendsAndRequestsCount(token: token)
            .sink { response in
                self.loading = false

                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.friendsCount = response.value!.friends
                    self.pendingCount = response.value!.pending
                    self.requestsCount = response.value!.requests
                }
            }.store(in: &cancellableSet)
    }
    
    func makeAlert(with error: NetworkError, for message: inout String ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert.toggle()
    }

}
