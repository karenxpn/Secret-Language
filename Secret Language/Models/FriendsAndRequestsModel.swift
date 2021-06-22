//
//  FriendsAndRequestsModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.06.21.
//

import Foundation
struct FriendsAndRequestsModel: Codable {
    var friends: Int
    var pending: Int
    var requests: Int
}
