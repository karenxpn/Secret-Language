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
    var messageCount: Int
    var message: ChatPreveiwMessage?
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
