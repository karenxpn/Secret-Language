//
//  AuthResponse.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 08.06.21.
//

import Foundation
struct AuthResponse: Codable {
    var id: Int
    var token: String
    var username: String
    var interestedIn: Int
}
