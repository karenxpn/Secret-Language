//
//  ContactResponseModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.06.21.
//

import Foundation
struct ContactResponseModel: Identifiable, Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var phone: String
    var image: Data?
    var invited: Bool
}
