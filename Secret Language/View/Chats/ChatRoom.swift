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
    
    init(roomID: Int, user: ChatUserModel) {
        
        self.roomID = roomID
        self.user = user
                
        roomVM.getChatRoomMessagesWithPusher()
        roomVM.getTypingStatus()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Background()

            VStack(spacing: 0) {
                MessagesList(roomID: roomID, username: user.name)
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
        }.fullScreenCover(isPresented: $roomVM.openSheet) {
            
            if roomVM.activeSheet == .gallery {
                Gallery()
                    .environmentObject(roomVM)
            } else if roomVM.activeSheet == .camera {
                EmptyView()
            }else {
               EmptyView()
            }

        }.actionSheet(item: $roomVM.action) { value in
            
            if value == .message {
                return ActionSheet(title: Text( NSLocalizedString("actions", comment: "") ), message: nil, buttons: [.default(Text( "Copy" ), action: {
                    UIPasteboard.general.string = roomVM.actionItem?.content[0].message
                }), .destructive(Text( "Delete" ), action: {
//                  delete item here
//                  print("delete item \(roomVM.actionItem?.id)")
                }), .cancel()])
            } else {
                return ActionSheet(title: Text( NSLocalizedString("selectSource", comment: "") ), message: nil, buttons: [.default(Text( "Gallery" ), action: {
                    
                    // open gallery
                    roomVM.activeSheet = .gallery
                    roomVM.openSheet.toggle()
                }), .default(Text( "Camera" ), action: {
                    // // open camera
                    roomVM.activeSheet = .camera
                    roomVM.openSheet.toggle()
                }), .cancel()])
            }
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(roomID: 1, user: ChatUserModel(id: 2, name: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business", age: 21))
    }
}
