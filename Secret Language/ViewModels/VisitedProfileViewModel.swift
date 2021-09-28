//
//  VisitedProfileViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 29.09.21.
//

import Foundation
import SwiftUI
import Combine

enum UserStatusChangeAlert {
    case report
    case removeFriend
}

class VisitedProfileViewModel: ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var alertType: UserStatusChangeAlert? = .none
    
    @Published var reportedOrBlockedAlert: Bool = false
    @Published var reportedOrBlockedAlertMessage: String = ""
    
    @Published var visitedProfile: VisitedUserModel? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ProfileServiceProtocol
    var userDataManager: UserServiceProtocol
    
    init(dataManager: ProfileServiceProtocol = ProfileService.shared,
         userDataManager: UserServiceProtocol = UserService.shared) {
        self.dataManager = dataManager
        self.userDataManager = userDataManager
    }
    
    func getVisitedProfile( userID: Int ) {
        loading = true
        dataManager.fetchVisitedProfile(token: token, userID: userID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(with: response.error!, message: &self.alertMessage, alert: &self.showAlert)
                } else {
                    self.visitedProfile = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func reportVisitedProfile( userID: Int ) {
        dataManager.reportUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.makeReportAlert(response: response.value!,
                                         alert: &self.reportedOrBlockedAlert,
                                         message: &self.reportedOrBlockedAlertMessage, type: &self.alertType)
                }
            }.store(in: &cancellableSet)
    }
    
    func blockVisitedProfile( userID: Int ) {
        dataManager.blockUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.makeReportAlert(response: response.value!,
                                         alert: &self.reportedOrBlockedAlert,
                                         message: &self.reportedOrBlockedAlertMessage, type: &self.alertType)
                }
            }.store(in: &cancellableSet)
    }
    
    func flagVisitedProfile( userID: Int ) {
        dataManager.flagUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.makeReportAlert(response: response.value!,
                                         alert: &self.reportedOrBlockedAlert,
                                         message: &self.reportedOrBlockedAlertMessage, type: &self.alertType)
                }
            }.store(in: &cancellableSet)
    }
    
    func connectUser( userID: Int ) {
        userDataManager.connectUser(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.visitedProfile?.friendStatus = 3
                }
            }.store(in: &cancellableSet)
    }
    
    func withdrawRequest( userID: Int ) {
        dataManager.withdrawFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.visitedProfile?.friendStatus = 1
                }
            }.store(in: &cancellableSet)
    }
    
    func acceptFriendRequest( userID: Int ) {
        dataManager.acceptFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.getVisitedProfile(userID: userID)
                }
            }.store(in: &cancellableSet)
    }
    
    func rejectFriendRequest( userID: Int ) {
        dataManager.rejectFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.visitedProfile?.friendStatus = 1
                }
            }.store(in: &cancellableSet)
    }
    
    func deleteFriend( userID: Int ) {
        dataManager.deleteFriend(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.visitedProfile?.friendStatus = 1
                }
            }.store(in: &cancellableSet)
    }
    
    func askDelete() {
        self.reportedOrBlockedAlertMessage =  "All your data with this user will be deleted( included chat messages )"
        self.alertType = .removeFriend
        self.reportedOrBlockedAlert.toggle()
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
    
    
    func makeAlert(with error: NetworkError, message: inout String, alert: inout Bool ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        alert.toggle()
    }
    
    func makeReportAlert( response: GlobalResponse, alert: inout Bool, message: inout String, type: inout UserStatusChangeAlert? ) {
        message = response.message
        type = .report
        alert.toggle()
    }
}
