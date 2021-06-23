//
//  ContactRequestModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 23.06.21.
//

import Foundation
struct ContactRequestModel: Codable {
    var firstName: String
    var lastName: String
    var phone: String
    var image: Data?
}

enum PermissionsError: Identifiable {
    var id: String { UUID().uuidString }
    case userError
    case fetchError(_: Error )
    var description: String {
        switch self {
        case .userError:
            return "Please change permissions in settings"
        case .fetchError(let error):
            return error.localizedDescription
        }
    }
}
