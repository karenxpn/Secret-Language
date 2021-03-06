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

class ChatViewModel: AlertViewModel, ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "shouldSubscribe" ) private var shouldSubscribe: Bool = false
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var page: Int = 1
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ChatServiceProtocol
    var channel: PusherChannel
    
    @Published var chats = [ChatModelViewModel]()
    
    init(dataManager: ChatServiceProtocol = ChatService.shared) {
        self.dataManager = dataManager
        self.channel = PusherManager.shared.channel
    }
    
    func getChats() {
        loading = true
        dataManager.fetchChatList(token: token, page: page)
            .sink { response in
                
                self.loading = false
                if response.error != nil {
                    if response.error!.initialError.responseCode == Credentials.paymentErrorCode {
                        self.shouldSubscribe = true
                    } else {
                        self.makeAlert(with: response.error!,
                                       message: &self.alertMessage,
                                       alert: &self.showAlert)
                    }
                } else {
                    self.shouldSubscribe = false
                    self.page += 1
                    self.chats.append(contentsOf: response.value!.map(ChatModelViewModel.init))
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
            self.page = 2
            self.chats = chats.map(ChatModelViewModel.init)
        }
    }
}
