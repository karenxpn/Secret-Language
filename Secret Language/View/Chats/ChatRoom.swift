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
    
    @StateObject var roomVM = MessageRoomViewModel()
    @State private var navigateToUser: Bool = false
    
    @State private var appeared: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Background()
            
            NavigationLink(destination: EmptyView()) {
                EmptyView()
            }
            
            NavigationLink(destination: VisitedProfile(userID: user.id, userName: user.name), isActive: $navigateToUser) {
                EmptyView()
            }.hidden()
            
            VStack(spacing: 0) {
                MessagesList(roomID: roomID, username: user.name)
                    .environmentObject(roomVM)
                
                
                if roomVM.sendingMediaMessage {
                    Text( NSLocalizedString("sendingMedia", comment: ""))
                        .foregroundColor(.accentColor)
                        .font(.custom("Avenir", size: 10))
                        .padding(.top)
                }
                
                MessageBar().environmentObject(roomVM)
            }
            
        }.navigationBarTitle("")
        .navigationBarTitleView(ChatRoomNavBar(navigate: $navigateToUser, user: user))
        .onAppear {
            NotificationCenter.default.post(name: Notification.Name("hideTabBar"), object: nil)
            self.appeared = true
            roomVM.roomID = roomID
            roomVM.removePusherHandlers()
            roomVM.getChatRoomMessagesWithPusher()
            roomVM.getTypingStatus()
            
            if roomVM.messages.isEmpty {
                roomVM.getChatRoomMessages( lastMessageID: 0)
            }
        }.onDisappear {
            self.appeared = false
            NotificationCenter.default.post(name: Notification.Name("showTabBar"), object: nil)
        }.fullScreenCover(isPresented: $roomVM.openSheet) {
            
            if roomVM.activeSheet == .gallery {
                Gallery()
                    .environmentObject(roomVM)
            } else if roomVM.activeSheet == .camera {
                CameraView()
                    .environmentObject(roomVM)
            } else {
                MessageMedia(media: roomVM.imageMessage?.content ?? [])
                    .environmentObject(roomVM)
            }
            
        }.actionSheet(item: $roomVM.action) { value in
            
            if value == .message {
                return ActionSheet(title: Text( NSLocalizedString("actions", comment: "") ), message: nil, buttons: [.default(Text( "Copy" ), action: {
                    UIPasteboard.general.string = roomVM.actionItem?.content[0].message
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
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if appeared {
                roomVM.getChatRoomMessages( lastMessageID: 0)
            }
        }
    }
}

struct ChatRoom_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoom(roomID: 1, user: ChatUserModel(id: 2, name: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business", age: 21))
    }
}
