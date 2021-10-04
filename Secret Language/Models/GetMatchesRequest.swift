//
//  GetMatchesRequest.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.06.21.
//

import Foundation
struct GetMatchesRequest: Codable {
    var gender: Int
    var interestedIn: Int
    var idealFor: [String]
    var minAge: Int
    var maxAge: Int
    var distance: Int
}
