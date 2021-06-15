//
//  CategoryItemModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 16.06.21.
//

import Foundation
struct CategoryItemModel: Identifiable, Codable {
    var id: Int
    var category: String
    var name: String
}
