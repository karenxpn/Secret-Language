//
//  Card.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import Foundation
import SwiftUI

struct MatchModel: Identifiable, Codable {
    var id: Int
    var username: String
    var name: String
    var age: Int
    var sln: String
    var sln_description: String
    var rel_image: String
    
    var report: String
    var advice: String
    var ideal_for: String
    
    var image: String
    var famous_years: String
    var my_birthday: String
    var my_birthday_name: String
    var user_birthday: String
    var user_birthday_name: String
    
    var distance: String
}

struct MatchViewModel: Identifiable {
    
    var match: MatchModel
    init( match: MatchModel ) {
        self.match = match
    }
    
    var id: Int {
        self.match.id
    }
    
    var name: String {
        self.match.name
    }
    
    var username: String {
        self.match.username
    }
    
    var age: Int {
        self.match.age
    }
    
    var image: String {
        self.match.image
    }
    
    var illustration: String {
        self.match.rel_image
    }
    
    var ideal: String {
        self.match.ideal_for
    }
    
    var title: String {
        self.match.sln
    }
    
    var sln_description: String {
        self.match.sln_description
    }
    
    var report: String {
        self.match.report.replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\r", with: "\r")
    }
    
    var famous_years: String {
        self.match.famous_years
    }
    
    var advice: String {
        self.match.advice
            .replacingOccurrences(of: "\\n", with: "\n")
            .replacingOccurrences(of: "\\r", with: "\r")
    }
    
    var partnerBirthday: String {
        self.match.user_birthday
    }
    
    var partnerBirthdayWeek: String {
        self.match.user_birthday_name
    }
    
    var myBirthday: String {
        self.match.my_birthday
    }
    
    var myBirthdayWeek: String {
        self.match.my_birthday_name
    }
    
    var distance: String {
        self.match.distance
    }
    
    // Card x position
    var x: CGFloat = 0.0
    // Card rotation angle
    var degree: Double = 0.0
    
}
