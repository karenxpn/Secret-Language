//
//  ConnectionTypeModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.06.21.
//

import Foundation
struct ConnectionTypeModel: Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
}
