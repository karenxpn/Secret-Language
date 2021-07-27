//
//  SettingsFields.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import Foundation
struct SettingsFields: Codable {
    var gender: GenderModel
    var birthday: String
    var location: String
    var fullName: String
}
