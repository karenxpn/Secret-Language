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
    var message: ChatPreveiwMessage
    var user: ChatUserModel
    var messageCount: Int
    var read: Bool
}

struct ChatPreveiwMessage: Codable {
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
    var ideal_for: String
    var age: Int
}
