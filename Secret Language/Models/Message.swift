//
//  Message.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import Foundation
struct Message: Identifiable, Codable, Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        lhs.created_at < rhs.created_at
    }
    
    var id: Int
    var content: [ContentModel]
    var sender: MessageUserModel
    var created_at: String
    var read: Bool
}

struct MessageUserModel: Identifiable, Codable {
    var id: Int
    var fullName: String
    var profile_image: String
}
