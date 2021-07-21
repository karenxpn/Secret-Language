//
//  FriendsViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import Foundation
import Combine
import SwiftUI
import PusherSwift

class ProfileViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    
    @Published var searchText: String = ""
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var profile: UserModel? = nil
    @Published var visitedProfile: MatchViewModel? = nil
    
    @Published var reportedOrBlockedAlert: Bool = false
    @Published var reportedOrBlockedAlertMessage: String = ""
    
    @Published var friendsList = [UserPreviewModel]()
    @Published var requestsList = [UserPreviewModel]()
    @Published var pendingList = [UserPreviewModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ProfileServiceProtocol
    var matchDataManager: MatchServiceProtocol
    var channel: PusherChannel
    
    init( dataManager: ProfileServiceProtocol = ProfileService.shared,
          matchDataManager: MatchServiceProtocol = MatchService.shared ) {
        self.dataManager = dataManager
        self.matchDataManager = matchDataManager
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
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func rejectFriendRequest( userID: Int ) {
        dataManager.rejectFriendRequest(token: token, userID: userID)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func withdrawFriendRequest( userID: Int ) {
        dataManager.withdrawFriendRequest(token: token, userID: userID)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func updateProfileImage(image: Data) {
        dataManager.updateProfileImage(token: self.token, image: image)
            .sink { (response) in
                
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.profile = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func deleteProfileImage() {
        dataManager.deleteProfileImage(token: token)
            .sink { response in
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.profile = response.value!
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
    
    func getVisitedProfile( userID: Int ) {
        loading = true
        matchDataManager.fetchSingleMatch(token: token, userID: userID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, for: &self.alertMessage)
                } else {
                    self.visitedProfile = MatchViewModel(match: response.value!)
                }
            }.store(in: &cancellableSet)
    }
    
    func reportVisitedProfile( userID: Int ) {
        dataManager.reportUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.reportedOrBlockedAlertMessage = "User is reported"
                    self.reportedOrBlockedAlert.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func blockVisitedProfile( userID: Int ) {
        dataManager.blockUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.reportedOrBlockedAlertMessage = "User is blocked"
                    self.reportedOrBlockedAlert.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func getProfileWithPusher() {
        dataManager.fetchProfileWithPusher(channel: channel) { profile in
            self.profile = profile
        }
    }
    
    func getFriendsWithPusher() {
        dataManager.fetchFriendsWithPusher(channel: channel) { friends in
            self.friendsList = friends
        }
    }
    
    func getFriendRequestsWithPusher() {
        dataManager.fetchFriendRequestsWithPusher(channel: channel) { requests in
            self.requestsList = requests
        }
    }
    
    func getPendingRequestsWithPusher() {
        dataManager.fetchPendingRequestsWithPusher(channel: channel) { requests in
            self.pendingList = requests
        }
    }
        
    func makeAlert(with error: NetworkError, for message: inout String ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert.toggle()
    }

}
