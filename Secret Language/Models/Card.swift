//
//  Card.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import Foundation
import SwiftUI
//MARK: - DATA
struct Card: Identifiable, Codable {
    let id: String = UUID().uuidString
    let name: String
    let imageName: String
    let age: Int
    let bio: String
    let ideal: [String]
    
    static var data: [Card] {
        [
            Card(name: "Rosie", imageName: "p0", age: 21, bio: "Insta - roooox 💋", ideal: ["Family", "Romance"]),
            Card(name: "Betty", imageName: "p1", age: 23, bio: "Like exercising, going out, pub, working 🍻", ideal: ["Family", "Romance"]),
            Card(name: "Abigail", imageName: "p2", age: 26, bio: "hi, let's be friends", ideal: ["Family", "Romance"]),
            Card(name: "Zoé", imageName: "p3", age: 20, bio: "Law grad", ideal: ["Family", "Romance"]),
            Card(name: "Tilly", imageName: "p4", age: 21, bio: "Follow me on IG", ideal: ["Family", "Romance"]),
            Card(name: "Penny", imageName: "p5", age: 24, bio: "J'aime la vie et le vin 🍷", ideal: ["Family", "Romance"]),
        ]
    }
}


struct CardViewModel: Identifiable {
    
    var card: Card
    init( card: Card ) {
        self.card = card
    }
    
    var id: String {
        self.card.id
    }
    
    var name: String {
        self.card.name
    }
    
    var image: String {
        self.card.imageName
    }
    
    var bio: String {
        self.card.bio
    }
    
    var ideal: [String] {
        self.card.ideal
    }
    
    // Card x position
    var x: CGFloat = 0.0
    // Card y position
    var y: CGFloat = 0.0
    // Card rotation angle
    var degree: Double = 0.0
    
}
