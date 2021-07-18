//
//  MessageRoomViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import Foundation
import SwiftUI
import Combine
import PusherSwift

enum SheetAction: Identifiable {
    var id: Self { self }
    case message
    case media
}

class MessageRoomViewModel: ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "userID" ) private var userID: Int = 0

    
    @Published var messageText: String = ""
    @Published var writingMessage: Bool = false
    @Published var loadingMessages: Bool = false
    @Published var messages = [Message]()
    
    @Published var lastMessageID: Int = 0
    @Published var roomID: Int = 0
    
    //ActionSheet
    @Published var action: SheetAction? = .none
    @Published var actionItem: Message? = nil
    @Published var imageMessage: Message? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ChatServiceProtocol
    var channel: PusherChannel
    
    init(dataManager: ChatServiceProtocol = ChatService.shared) {
        self.dataManager = dataManager
        channel = PusherManager.shared.channel
    }
    
    func getChatRoomMessages( lastMessageID: Int ) {
        loadingMessages = true
        dataManager.fetchRoomMessages(token: token, roomID: roomID, lastMessageID: lastMessageID)
            .sink { response in
                self.loadingMessages = false
                
                if response.error == nil {
                    let messages = response.value!
                    self.messages.append(contentsOf: messages.reversed())
                    if !messages.isEmpty {
                        self.lastMessageID = self.messages[0].id
                    }
                }
            }.store(in: &cancellableSet)
    }
    
    func getChatRoomMessagesWithPusher() {
        dataManager.fetchMessagesListWithPusher(channel: channel, roomID: roomID) { message in
            self.messages.insert(message, at: 0)
        }
    }
    
    func sendTypingStatus() {
        
    }
}
