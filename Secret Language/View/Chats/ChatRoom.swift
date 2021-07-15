//
//  ChatRoom.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import SwiftUI

struct ChatRoom: View {
    
    let roomID: Int
    let user: ChatUserModel
    
    var body: some View {
        ZStack {
            Background()
            
        }.navigationBarTitle("")
        .navigationBarTitleView(ChatRoomNavBar(user: user))
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(roomID: 1, user: ChatUserModel(id: 2, name: "Karen Mirakyan", ideal_for: "Business", age: 21))
    }
}
