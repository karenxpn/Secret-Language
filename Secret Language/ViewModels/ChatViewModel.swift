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
    
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ChatServiceProtocol
    var channel: PusherChannel

    
    @Published var chats = [ChatModel(id: 1, chatName: "Karen Mirakyan", image: "", messageCount: 4, message: ChatPreveiwMessage(type: "text", content: [ContentModel(message: "hello", type: "text")], created_at: "1d ago"), read: false), ChatModel(id: 2, chatName: "Karen Mirakyan", image: "", messageCount: 4, message: ChatPreveiwMessage(type: "text", content: [ContentModel(message: "hello", type: "text")], created_at: "1d ago"), read: false), ChatModel(id: 3, chatName: "Karen Mirakyan", image: "", messageCount: 4, message: ChatPreveiwMessage(type: "text", content: [ContentModel(message: "hello", type: "text")], created_at: "1d ago"), read: false)]
    
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
                    self.makeAlert(with: response.error!, for: &self.alertMessage, showAlert: &self.showAlert)
                } else {
                    self.chats = response.value!
                }
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
