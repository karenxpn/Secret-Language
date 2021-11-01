//
//  VisitedUserModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.09.21.
//

import Foundation
import SwiftUI

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
    var looking_for: String
}

struct VisitedUserViewModel: Codable, Identifiable {
    var user: VisitedUserModel
    
    init(user: VisitedUserModel) {
        self.user = user
    }
    
    var id: Int                     { self.user.id }
    var username: String            { self.user.username }
    var name: String                { self.user.name }
    var age: Int                    { self.user.age }
    var sln: String                 { self.user.sln }
    var sln_description: String     { self.user.sln_description }
    var rel_image: String           { self.user.rel_image }
    
    var report: String              { self.user.report }
    var advice: String              { self.user.advice }
    var ideal_for: String           { self.user.ideal_for }
    
    var images: [ProfileGalleryItemViewModel] {
        self.user.images.map{ ProfileGalleryItemViewModel(item: $0,
                                                          width: UIScreen.main.bounds.size.width - 24,
                                                          height: UIScreen.main.bounds.size.height * 0.7)}
    }
    
    var famous_years: String        { self.user.famous_years }
    var my_birthday: String         { self.user.my_birthday }
    var my_birthday_name: String    { self.user.my_birthday_name }
    var user_birthday: String       { self.user.user_birthday }
    var user_birthday_name: String  { self.user.user_birthday_name }
    
    var distance: String            { self.user.distance }
    var instagram: String           { self.user.instagram }
    var signUpDate: String          { self.user.signUpDate }
    var friendStatus: Int {
        get { self.user.friendStatus }
        set { self.user.friendStatus = newValue }
    }
    
    var chatId: Int?                { self.user.chatId }
    var looking_for: String         { self.user.looking_for }
}
