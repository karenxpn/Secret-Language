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
    
    @Published var sharedProfile: SharedProfileModel? = nil
    
    @Published var friendsList = [UserPreviewModel]()
    @Published var requestsList = [UserPreviewModel]()
    @Published var pendingList = [UserPreviewModel]()
    
    @Published var loadingImages: Bool = false
    @Published var profileImages: ProfileGalleryResponse? = nil
    
    @Published var page: Int = 1
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ProfileServiceProtocol
    var matchDataManager: MatchServiceProtocol
    var chatDataManager: ChatServiceProtocol
    var channel: PusherChannel
    
    init( dataManager: ProfileServiceProtocol = ProfileService.shared,
          matchDataManager: MatchServiceProtocol = MatchService.shared,
          chatDataManager: ChatServiceProtocol = ChatService.shared ) {
        self.dataManager = dataManager
        self.matchDataManager = matchDataManager
        self.chatDataManager = chatDataManager
        self.channel = PusherManager.shared.channel
    }
    
    func getFriends() {
        loading = true
        dataManager.fetchFriends(token: token, page: page)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.friendsList.append(contentsOf: response.value!)
                }
            }.store(in: &cancellableSet)
    }
    
    func getFriendRequests() {
        loading = true
        dataManager.fetchFriendRequests(token: token, page: page)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.requestsList.append(contentsOf: response.value!)
                }
            }.store(in: &cancellableSet)
    }
    
    func getPendingRequests() {
        loading = true
        dataManager.fetchPendingRequests(token: token, page: page)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.pendingList.append(contentsOf: response.value!)
                }
            }.store(in: &cancellableSet)
    }
    
    func sendGreetingMessage(userID: Int) {
        chatDataManager.sendGreetingMessage(token: token, userID: userID, message: SendingMessageModel(type: "text", content: "👋🏻")).sink { response in
            
            if response.error != nil {
                self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
            } else {
                self.alertMessage = response.value!.message
                self.showAlert.toggle()
            }
            
        }.store(in: &cancellableSet)
    }
    
    // requests flow
    func acceptFriendRequest( userID: Int ) {
        dataManager.acceptFriendRequest(token: token, userID: userID)
            .sink { response in
                
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    if let index = self.requestsList.firstIndex(where: { $0.id == userID }) {
                        self.requestsList.remove(at: index)
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func rejectFriendRequest( userID: Int ) {
        dataManager.rejectFriendRequest(token: token, userID: userID)
            .sink { response in
                
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    if let index = self.requestsList.firstIndex(where: { $0.id == userID }) {
                        self.requestsList.remove(at: index)
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func withdrawFriendRequest( userID: Int ) {
        dataManager.withdrawFriendRequest(token: token, userID: userID)
            .sink { response in
                
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    if let index = self.pendingList.firstIndex(where: { $0.id == userID }) {
                        self.pendingList.remove(at: index)
                    }
                }                
            }.store(in: &cancellableSet)
    }
    
    func getProfile() {
        loading = true
        dataManager.fetchProfile(token: token)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.profile = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getProfileImages() {
        loadingImages = true
        dataManager.fetchProfileImageGallery(token: token)
            .sink { response in
                self.loadingImages = false
                if response.error == nil {
                    self.profileImages = response.value!
                } else {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                }
            }.store(in: &cancellableSet)
    }
    
    func addProfileImage(image: Data) {
        loadingImages = true
        dataManager.addProfileImageToGallery(token: token, image: image)
            .sink { response in
                self.loadingImages = false
                if response.error == nil {
                    self.profileImages = response.value!
                } else {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                }
            }.store(in: &cancellableSet)
    }
    
    func removeProfileImage(id: Int) {
        loadingImages = true
        dataManager.deleteProfileImageFromGallery(token: token, imageID: id)
            .sink { response in
                self.loadingImages = false
                if response.error == nil {
                    self.profileImages = response.value!
                } else {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                }
            }.store(in: &cancellableSet)
    }
    
    func makeProfileImage( id: Int ) {
        loadingImages = true
        dataManager.makeProfileImage(token: token, imageID: id)
            .sink { response in
                self.loadingImages = false
                if response.error == nil {
                    self.profileImages = response.value!
                } else {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                }
            }.store(in: &cancellableSet)
    }
    
    func getVisitedProfile( userID: Int ) {
        loading = true
        matchDataManager.fetchSingleMatch(token: token, userID: userID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.visitedProfile = MatchViewModel(match: response.value!)
                }
            }.store(in: &cancellableSet)
    }
    
    func reportVisitedProfile( userID: Int ) {
        dataManager.reportUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.makeReportAlert(response: response.value!,
                                         alert: &self.reportedOrBlockedAlert,
                                         message: &self.reportedOrBlockedAlertMessage)
                }
            }.store(in: &cancellableSet)
    }
    
    func blockVisitedProfile( userID: Int ) {
        dataManager.blockUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.makeReportAlert(response: response.value!,
                                         alert: &self.reportedOrBlockedAlert,
                                         message: &self.reportedOrBlockedAlertMessage)
                }
            }.store(in: &cancellableSet)
    }
    
    func flagVisitedProfile( userID: Int ) {
        dataManager.flagUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.makeReportAlert(response: response.value!,
                                         alert: &self.reportedOrBlockedAlert,
                                         message: &self.reportedOrBlockedAlertMessage)
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedProfile(userID: Int) {
        loading = true
        dataManager.fetchSharedProfile(userID: userID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.sharedProfile = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func shareProfile( userID: Int ) {
        let url = URL(string: "https://secretlanguage.network/v1/profile/share?id=\(userID)")!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
    
    func openInstagram( username: String ) {
        
        let appURL = URL(string: "instagram://user?username=\(username)")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            let webURL = URL(string: "https://instagram.com/\(username)")!
            application.open(webURL)
        }
    }
    
    func getProfileWithPusher() {
        dataManager.fetchProfileWithPusher(channel: channel) { profile in
            self.profile?.requests = profile.requests
            self.profile?.pending = profile.pending
            self.profile?.friends = profile.friends
        }
    }
        
    func makeAlert(with error: NetworkError, message: inout String, alert: inout Bool ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        alert.toggle()
    }
    
    func makeReportAlert( response: GlobalResponse, alert: inout Bool, message: inout String ) {
        message = response.message
        alert.toggle()
    }
}
