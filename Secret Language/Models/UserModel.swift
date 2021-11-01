//
//  UserModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.06.21.
//

import Foundation
struct UserModel: Identifiable, Codable {
    var id: Int
    var image: String
    var name: String
    var age: Int
    var friends: Int
    var pending: Int
    var requests: Int
    var birthday_report: BirthdayReportModel
}

struct UserViewModel: Identifiable, Codable {
    var user: UserModel
    
    init(user: UserModel) {
        self.user = user
    }
    
    var id: Int { self.user.id }
    var image: String { self.user.image + "?tr=w-110,h-110" }
    var name: String { self.user.name }
    var age: Int { self.user.age }
    var friends: Int {
        get { self.user.friends }
        set { self.user.friends = newValue }
    }
    var pending: Int {
        get { self.user.pending }
        set { self.user.pending = newValue }
    }
    
    var requests: Int {
        get { self.user.requests }
        set { self.user.requests = newValue }
    }
    var birthday_report: BirthdayReportModel { self.user.birthday_report }
}
