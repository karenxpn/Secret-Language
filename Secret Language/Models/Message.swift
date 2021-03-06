//
//  Message.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import Foundation
struct Message: Identifiable, Codable {
    var id: Int
    var content: [ContentModel]
    var user: MessageUserModel
    var created_at: String
    var read: Bool
}

struct MessageUserModel: Identifiable, Codable {
    var id: Int
    var name: String
    var image: String
}
