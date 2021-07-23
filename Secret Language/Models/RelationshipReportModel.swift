//
//  RelationshiopReportModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 03.07.21.
//

import Foundation
struct RelationshipReportModel: Codable, Identifiable {
    var id: Int
    var shareId: Int
    var birthday_1: String
    var birthday_1_name: String
    var birthday_2: String
    var birthday_2_name: String
    var image: String
    var name: String
    var s1: String
    var s2: String
    var s3: String
    var w1: String
    var w2: String
    var w3: String
    var ideal_for: String
    var report: String
    var advice: String
    var problematic_for: String
}
