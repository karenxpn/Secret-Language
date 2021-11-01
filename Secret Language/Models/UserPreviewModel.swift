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
}

struct UserPreviewViewModel: Identifiable {
    
    var user: UserPreviewModel
    init( user: UserPreviewModel ) {
        self.user = user
    }
    
    var id: Int {
        self.user.id
    }
    
    var image: String {
        print(user.image + "?tr=w-50,h-50")
        return user.image + "?tr=w-50,h-50"
        
    }
    var name: String { user.name }
    var ideal: String { user.ideal }
}
