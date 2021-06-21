//
//  FriendsNavBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI

struct FriendsNavBar: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.custom("Gilroy-Bold", size: 16))
    }
}

struct FriendsNavBar_Previews: PreviewProvider {
    static var previews: some View {
        FriendsNavBar(title: "My Requests" )
    }
}
