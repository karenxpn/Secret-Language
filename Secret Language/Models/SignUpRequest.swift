//
//  SignUpRequest.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 07.06.21.
//

import Foundation
struct SignUpRequest: Codable {
    var phoneNumber: String
    var birthday: String
    var gender: Int
    var interested_in : Int
}
