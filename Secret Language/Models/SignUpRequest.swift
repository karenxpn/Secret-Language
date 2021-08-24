//
//  SignUpRequest.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 07.06.21.
//

import Foundation
struct SignUpRequest: Codable {
    var name: String
    var gender: Int
    var interested_in : Int
    var gender_preference: Int
}
