//
//  VisitedUserModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.09.21.
//

import Foundation
struct VisitedUserModel: Codable, Identifiable {
    var id: Int
    var username: String
    var name: String
    var age: Int
    var sln: String
    var sln_description: String
    var rel_image: String
    
    var report: String
    var advice: String
    var ideal_for: String
    
    var images: [ProfileGalleryItem]
    var famous_years: String
    var my_birthday: String
    var my_birthday_name: String
    var user_birthday: String
    var user_birthday_name: String
    
    var distance: String
    var instagram: String
    var signUpDate: String
    var friendStatus: Int
    var chatId: Int?
}
