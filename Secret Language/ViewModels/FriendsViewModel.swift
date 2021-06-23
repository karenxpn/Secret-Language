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

class FriendsViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    
    @Published var searchText: String = ""
    @Published var friendsCount: Int = 0
    @Published var pendingCount: Int = 0
    @Published var requestsCount: Int = 0
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var friendsList = [UserPreviewModel]()
    @Published var requestsList = [UserPreviewModel]()
    @Published var pendingList = [UserPreviewModel]()
    
    // contacts
    @Published var contacts = [ContactModel]()
    @Published var permissionError: PermissionsError? = .none
    
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
    
    func acceptFriendRequest( userID: Int ) {
        dataManager.acceptFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.friendsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func rejectFriendRequest( userID: Int ) {
        dataManager.rejectFriendRequest(token: token, userID: userID)
            .sink { response in
                if response.error == nil {
                    self.friendsList = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    // contacts
    func getContacts() {
        
        dataManager.fetchContacts { contacts in
            self.contacts = contacts
        }
    }
    
    func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            getContacts()
        case .notDetermined, .restricted, .denied:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                switch granted {
                case true:
                    self.getContacts()
                case false:
                    DispatchQueue.main.async {
                        self.permissionError = .userError
                    }
                }
            }
            
        default:
            fatalError( "Unknown Error!" )
        }
    }
        
    func makeAlert(with error: NetworkError, for message: inout String ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert.toggle()
    }

}
