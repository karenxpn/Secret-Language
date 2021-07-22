//
//  ReportModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 03.07.21.
//

import Foundation
struct BirthdayReportModel: Codable, Identifiable {
    var id: Int
    var shareId: Int
    var date_name: String
    var sln: String
    var sln_description: String
    var famous_years: String

    var day_report: DayReportModel
    var week_report: WeekReportModel
    var month_report: MonthReportModel
    var season_report: SeasonReportModel
    var way_report: WayReportModel
    var path_report: PathReportModel
    var relationship_report: RelationshipReportModel
}

struct DayReportModel: Codable, Identifiable {
    var id: Int
    var day: Int
    var date_name: String
    var day_name: String
    var day_name_short: String
    var s1: String
    var s2: String
    var s3: String
    var w1: String
    var w2: String
    var w3: String
    var meditation: String
    var report: String
    var numbers: String
    var health: String
    var advice: String
    var archetype: String
    var famous: [FamousModel]
    var image: String
}

struct WeekReportModel: Codable, Identifiable {
    var id: Int
    var date_span: String
    var name_long: String
    var report: String
    var advice: String
    var s1: String
    var s2: String
    var s3: String
    var w1: String
    var w2: String
    var w3: String
    var famous: [FamousModel]
    var image: String
}

struct MonthReportModel: Codable, Identifiable {
    var id: Int
    var span1: String
    var name: String
    var sign: String
    var season: String
    var mode: String
    var motto: String
    var report: String
    var personality: String
    var image: String
}

struct SeasonReportModel: Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var span1: String
    var season_name: String
    var activity: String
    var report: String
    var faculty: String
    var image: String
}

struct WayReportModel: Codable, Identifiable {
    var id: Int
    var name: String
    var image: String
    var week_from: String
    var week_to: String
    var s1: String
    var s2: String
    var s3: String
    var w1: String
    var w2: String
    var w3: String
    var report: String
    var suggestion: String
    var lesson: String
    var goal: String
    var release: String
    var reward: String
    var balance: String
    var famous: [FamousModel]
}

struct PathReportModel: Codable, Identifiable {
    var id: Int
    var prefix: String
    var way_name: String
    var name_long: String
    var name_medium: String
    var image: String
    var challenge: String
    var fulfillment: String
    var report: String
}
