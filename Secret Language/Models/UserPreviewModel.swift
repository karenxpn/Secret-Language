//
//  UserPreviewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import Foundation
struct UserPreviewModel: Identifiable, Codable {
    var id: Int
    var name: String
    var image: String
    var ideal: String
    // var connecting: Bool
}
