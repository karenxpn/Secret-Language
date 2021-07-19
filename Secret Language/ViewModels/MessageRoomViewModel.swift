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

enum ActiveGallerySheet {
   case gallery, camera, media
   var id: Int {
      hashValue
   }
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
    
    @Published var activeSheet: ActiveGallerySheet? = .none
    @Published var openSheet: Bool = false
    
    @Published var senderIsTyping: Bool = false
        
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
        dataManager.sendTypingStatus(token: token, roomID: roomID, typing: writingMessage)
            .sink { _ in }.store(in: &cancellableSet)
    }
    
    func getTypingStatus() {
        dataManager.getTypingStatus(channel: channel, token: token, roomID: roomID) { typing in
            withAnimation {
                self.senderIsTyping = typing
            }
        }
    }
    
    func sendMessage(message: SendingMessageModel) {
        dataManager.sendMessage(token: token, roomID: roomID, message: message)
            .sink { response in
                if response.error == nil {
                    self.messageText = ""
                }
            }.store(in: &cancellableSet)
    }
}
