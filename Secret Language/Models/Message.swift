//
//  Message.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import Foundation
struct Message: Identifiable, Codable, Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.created_at < rhs.created_at
    }
    
    var id: Int
    var content: [ContentModel]
    var sender: ChatUserModel
    var created_at: String
    var read: Bool
}
