//
//  SharedProfileModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.07.21.
//

import Foundation
struct SharedProfileModel: Identifiable, Codable {
    var id: Int
    var name: String
    var age: Int
    var images: [String]
    var user_birthday: String
    var user_birthday_name: String

    var sln: String
    var sln_description: String
    
    var report: String
    var advice: String    
    var famous_years: String
    var distance: String
    var instagram: String
}
