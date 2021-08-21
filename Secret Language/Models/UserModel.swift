//
//  UserModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 24.06.21.
//

import Foundation
struct UserModel: Codable {
    var id: Int
    var image: String
    var name: String
    var age: Int
    var friends: Int
    var pending: Int
    var requests: Int
    var birthday_report: BirthdayReportModel
}
