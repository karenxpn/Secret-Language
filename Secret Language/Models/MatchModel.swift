//
//  Card.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import Foundation
import SwiftUI
//MARK: - DATA
struct MatchModel: Identifiable, Codable {
    var id: Int
    var title: String

    var s1: String
    var s2: String
    var s3: String

    var w1: String
    var w2: String
    var w3: String

    var report: String
    var advice: String
    var ideal: String
    var problematic: String
    
    var image: String
    var name: String
    var content: String
    var my_birthday: String
    var my_birthday_name: String
    var user_birthday: String
    var user_birthday_name: String
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
    
    var image: String {
        self.match.image
    }
    
    var ideal: String {
        self.match.ideal
    }
    
    var title: String {
        self.match.title
    }
    
    var content: String {
        self.match.content
    }
    
    var advice: String {
        self.match.advice
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
    
    // Card x position
    var x: CGFloat = 0.0
    // Card rotation angle
    var degree: Double = 0.0
    
}
