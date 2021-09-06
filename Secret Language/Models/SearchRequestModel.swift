//
//  SearchRequestModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.09.21.
//

import Foundation
struct SearchRequestModel: Codable {
    var input : String
    var gender : Int
    var interestedIn : Int
}
