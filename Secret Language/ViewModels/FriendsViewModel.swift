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
    
    @Published var loadingFriends: Bool = false
    @Published var loadingRequests: Bool = false
    
    @Published var friendsList = [UserPreviewModel]()
    @Published var requestsList = [UserPreviewModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: FriendsServiceProtocol
    
    init( dataManager: FriendsServiceProtocol = FriendsService.shared) {
        self.dataManager = dataManager
    }
    
    func getFriends() {
        loadingFriends = true
        dataManager.fetchFriends(token: token)
            .sink { response in
                self.loadingFriends = false
                if response.error != nil {
                    
                } else {
                    self.friendsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getFriendRequests() {
        loadingRequests = true
        dataManager.fetchFriendRequests(token: token)
            .sink { response in
                self.loadingRequests = false
                if response.error != nil {
                    
                } else {
                    self.requestsList = response.value!
                }
            }.store(in: &cancellableSet)
    }

}
