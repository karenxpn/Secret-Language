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
    
    @ObservedObject var roomVM = MessageRoomViewModel()
    
    var body: some View {
        ZStack {
            Background()
            
            MessagesList(roomID: roomID)
                .environmentObject(roomVM)
            
            VStack {
                Spacer()
                
                MessageBar().environmentObject(roomVM)
            }

        }.navigationBarTitle("")
        .navigationBarTitleView(ChatRoomNavBar(user: user))
        .onAppear {
            NotificationCenter.default.post(name: Notification.Name("hideTabBar"), object: nil)
        }.onDisappear {
            NotificationCenter.default.post(name: Notification.Name("showTabBar"), object: nil)
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(roomID: 1, user: ChatUserModel(id: 2, name: "Karen Mirakyan", ideal_for: "Business", age: 21))
    }
}
