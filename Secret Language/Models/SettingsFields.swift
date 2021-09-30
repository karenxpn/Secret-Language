//
//  SettingsFields.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import Foundation
struct SettingsFields: Codable {
    var gender: GenderModel
    var date_name: String
    var country_name: String
    var name: String
    var instagram: String
    var gender_preference: Int
    var interested_in: ConnectionTypeModel
    var canEditLocation: Bool
}
