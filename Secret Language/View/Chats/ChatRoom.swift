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
        ZStack(alignment: .bottom) {
            Background()

            VStack(spacing: 0) {
                MessagesList(roomID: roomID)
                    .environmentObject(roomVM)
                
                MessageBar().environmentObject(roomVM)
            }

        }.navigationBarTitle("")
        .navigationBarTitleView(ChatRoomNavBar(user: user))
        .onAppear {
            NotificationCenter.default.post(name: Notification.Name("hideTabBar"), object: nil)
            
            // check if the roomID is 0 -> create new room
            // else get messages
            
            if roomID == 0 {
                
            } else {
                roomVM.roomID = roomID
                if roomVM.messages.isEmpty {
                    roomVM.getChatRoomMessages( lastMessageID: 0)
                }
            }
        }.onDisappear {
            NotificationCenter.default.post(name: Notification.Name("showTabBar"), object: nil)
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(roomID: 1, user: ChatUserModel(id: 2, name: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business", age: 21))
    }
}
