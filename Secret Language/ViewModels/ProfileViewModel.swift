//
//  FriendsViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import Foundation
import Contacts
import Combine
import SwiftUI
import PusherSwift

class ProfileViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "username" ) private var username: String = ""
    
    @Published var searchText: String = ""
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var profile: UserModel? = nil
    
    @Published var friendsList = [UserPreviewModel]()
    @Published var requestsList = [UserPreviewModel]()
    @Published var pendingList = [UserPreviewModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ProfileServiceProtocol
    var channel: PusherChannel
    
    init( dataManager: ProfileServiceProtocol = ProfileService.shared) {
        self.dataManager = dataManager
        self.channel = PusherManager.shared.channel
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
    
    func getPendingRequests() {
        loading = true
        dataManager.fetchPendingRequests(token: token)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.pendingList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func acceptFriendRequest( userID: Int ) {
        dataManager.acceptFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.requestsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func rejectFriendRequest( userID: Int ) {
        dataManager.rejectFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.requestsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func withdrawFriendRequest( userID: Int ) {
        dataManager.withdrawFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.pendingList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func updateProfileImage(image: Data) {
        dataManager.updateProfileImage(token: self.token, image: image)
            .sink { (dataResponse) in
                
                if dataResponse.error != nil {
                    self.makeAlert(with: dataResponse.error!, for: &self.alertMessage)
                } else {
                    self.getProfile()
                }
            }.store(in: &cancellableSet)
    }
    
    func deleteProfileImage() {
        dataManager.deleteProfileImage(token: token)
            .sink { response in
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.getProfile()
                }
            }.store(in: &cancellableSet)
    }
    
    func getProfile() {
        
        loading = true
        dataManager.fetchProfile(token: token)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.profile = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getProfileWithPusher() {
        dataManager.fetchProfileWithPusher(channel: channel, username: username) { profile in
            self.profile = profile
        }
    }
    
    func getFriendsWithPusher() {
        dataManager.fetchFriendsWithPusher(channel: channel, username: username) { friends in
            self.friendsList = friends
        }
    }
    
    func getFriendRequestsWithPusher() {
        dataManager.fetchFriendRequestsWithPusher(channel: channel, username: username) { requests in
            self.requestsList = requests
        }
    }
    
    func getPendingRequestsWithPusher() {
        dataManager.fetchPendingRequestsWithPusher(channel: channel, username: username) { requests in
            self.pendingList = requests
        }
    }
        
    func makeAlert(with error: NetworkError, for message: inout String ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert.toggle()
    }

}
