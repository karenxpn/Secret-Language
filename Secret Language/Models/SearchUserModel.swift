//
//  SearchUserModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import Foundation

struct SearchUserModel: Identifiable, Codable {
    var id: Int
    var name: String
    var image: String
    var ideal: String
    var friendshipStatus: Int
}
