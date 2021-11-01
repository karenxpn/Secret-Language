//
//  SearchUserModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import Foundation

struct SearchUserModel: Identifiable, Codable {
    var id: Int
    var name: String
    var image: String
    var ideal: String
    var friendStatus: Int
}

struct SearchUserViewModel: Identifiable, Codable {
    
    var user: SearchUserModel
    init( user: SearchUserModel ) {
        self.user = user
    }
    
    var id: Int { self.user.id }
    var name: String { self.user.name }
    var image: String { self.user.image + "?tr=w-50,h-50" }
    var ideal: String { self.user.ideal }
    var friendStatus: Int {
        get { self.user.friendStatus }
        set { self.user.friendStatus = newValue }
    }
}
