//
//  ChatRoomNavBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI

struct ChatRoomNavBar: View {
    let name: String
    let age: Int
    let ideal_for: String
    
    var body: some View {
        VStack {
            Text( "\(name), \(age)" )
                .foregroundColor(.white)
                .font(.custom("times", size: 16))
                .fontWeight(.semibold)
            
            HStack( spacing: 0 ) {
                Text( NSLocalizedString("idealFor", comment: ""))
                    .foregroundColor(.gray)
                    .font(.custom("Avenir", size: 10))
                
                Text(ideal_for)
                    .foregroundColor(.accentColor)
                    .font(.custom("Avenir", size: 10))
            }
        }
    }
}

struct ChatRoomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomNavBar(name: "Karen Mirakyan", age: 21, ideal_for: "Family, Friendship, Romance, Love.")
    }
}
