//
//  ChatModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import Foundation
struct ChatModel: Identifiable, Codable {
    var id: Int
    var chatName: String
    var image: String
    var message: ChatPreveiwMessage?
    var user: ChatUserModel
    var unread_messages_count: String
    var read: Bool
}

struct ChatPreveiwMessage: Codable, Identifiable {
    var id: Int
    var type: String
    var content: [ContentModel]
    var created_at: String
}

struct ContentModel: Codable, Hashable {
    var message: String
    var type: String
}

struct ChatUserModel: Codable, Identifiable {
    var id: Int
    var name: String
    var image: String
    var ideal_for: String
    var age: Int
}


struct ChatModelViewModel: Identifiable, Codable {
    var chat: ChatModel
    
    init( chat: ChatModel ) {
        self.chat = chat
    }
    
    var id: Int                         { self.chat.id }
    var chatName: String                { self.chat.chatName }
    var image: String                   { self.chat.image + "?tr=w-55,h-55"}
    var unread_messages_count: String   { self.chat.unread_messages_count}
    var read: Bool                      { self.chat.read }
    var message: ChatPreveiwMessage?    { self.chat.message}
    var user: ChatUserModel             { self.chat.user }
}
