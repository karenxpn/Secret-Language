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
    let id: String = UUID().uuidString
    let name: String
    let imageName: String
    let age: Int
    let bio: String
    let ideal: [String]
    
    static var data: [MatchModel] {
        [
            MatchModel(name: "Rosie", imageName: "testImage", age: 21, bio: "Insta - roooox 💋", ideal: ["Family", "Romance"]),
            MatchModel(name: "Betty", imageName: "testImage", age: 23, bio: "Like exercising, going out, pub, working 🍻", ideal: ["Family", "Romance"]),
            MatchModel(name: "Abigail", imageName: "testImage", age: 26, bio: "hi, let's be friends", ideal: ["Family", "Romance"]),
            MatchModel(name: "Zoé", imageName: "testImage", age: 20, bio: "Law grad", ideal: ["Family", "Romance"]),
            MatchModel(name: "Tilly", imageName: "testImage", age: 21, bio: "Follow me on IG", ideal: ["Family", "Romance"]),
            MatchModel(name: "Penny", imageName: "testImage", age: 24, bio: "J'aime la vie et le vin 🍷", ideal: ["Family", "Romance"]),
        ]
    }
}


struct MatchViewModel: Identifiable {
    
    var match: MatchModel
    init( match: MatchModel ) {
        self.match = match
    }
    
    var id: String {
        self.match.id
    }
    
    var name: String {
        self.match.name
    }
    
    var image: String {
        self.match.imageName
    }
    
    var bio: String {
        self.match.bio
    }
    
    var ideal: [String] {
        self.match.ideal
    }
    
    // Card x position
    var x: CGFloat = 0.0
    // Card rotation angle
    var degree: Double = 0.0
    
}
