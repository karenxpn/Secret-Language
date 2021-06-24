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
    
    @AppStorage( "storedContacts" ) private var contactsStored: Bool = false
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
    @Published var contacts = [ContactResponseModel]()
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
    
    // contacts
    func postContacts() {
        
        dataManager.fetchContacts { contacts in
            
            self.dataManager.postContacts(contacts: contacts, token: self.token)
                .sink { response in
                    if response.error == nil {
                        self.contactsStored = true
                        self.contacts = response.value!
                    } else {
                        print(response.error!)
                    }
                }.store(in: &self.cancellableSet)
        }
    }
    
    func getContacts() {
        dataManager.fetchContacts(token: token)
            .sink { response in
                if response.error == nil {
                    self.contacts = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func permissions() {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            postContacts()
        case .notDetermined, .restricted, .denied:
            CNContactStore().requestAccess(for: .contacts) { granted, error in
                switch granted {
                case true:
                    self.postContacts()
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
