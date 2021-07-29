//
//  ChatViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import Foundation
import Combine
import SwiftUI
import PusherSwift

class ChatViewModel: ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "shouldSubscribe" ) private var shouldSubscribe: Bool = false
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ChatServiceProtocol
    var channel: PusherChannel
    
    @Published var chats = [ChatModel]()
    
    init(dataManager: ChatServiceProtocol = ChatService.shared) {
        self.dataManager = dataManager
        self.channel = PusherManager.shared.channel
        
        getChats()
    }
    
    func getChats() {
        loading = true
        dataManager.fetchChatList(token: token)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    if response.error!.initialError.responseCode == Credentials.paymentErrorCode {
                        self.shouldSubscribe = true
                    } else {
                        self.makeAlert(with: response.error!, for: &self.alertMessage, showAlert: &self.showAlert)
                    }
                } else {
                    self.shouldSubscribe = false
                    self.chats = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func deleteChat(index: Int) {
        dataManager.deleteChat(token: token, roomID: chats[index].id)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func getChatsWithPusher() {
        dataManager.fetchChatListWithPusher(channel: channel) { chats in
            self.chats = chats
        }
    }
    
    func makeAlert( with error: NetworkError, for alertMessage: inout String, showAlert: inout Bool) {
        alertMessage = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        showAlert.toggle()
    }
}
