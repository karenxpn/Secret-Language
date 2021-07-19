//
//  MessagesList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI

struct MessagesList: View {
    
    @EnvironmentObject var roomVM: MessageRoomViewModel
    let roomID: Int
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { scrollView in
                
                LazyVStack(spacing: 15) {
                    
                    if roomVM.senderIsTyping {
                        // show typing status
                        ProgressView()
                            .id(-1)
                    }
                    
                    ForEach(roomVM.messages, id: \.id) { message in
                        SingleMessage(message: message)
                            .environmentObject(roomVM)
                            .padding(.bottom, roomVM.messages[0].id == message.id ? UIScreen.main.bounds.size.height * 0.05 : 0)
                            .rotationEffect(.radians(3.14))
                            .onAppear {
                                if message.id == roomVM.messages[roomVM.messages.count-1].id {
                                    roomVM.getChatRoomMessages(lastMessageID: message.id)
                                    // Load new page of messages
                                }
                            }
                    }
                    
                    if roomVM.loadingMessages {
                        ProgressView()
                            .padding()
                    }
                    
                }.padding([.bottom], 20)
                .onChange(of: roomVM.writingMessage) { (_) in
                    if roomVM.writingMessage {
                        roomVM.sendTypingStatus()
                        withAnimation {
                            scrollView.scrollTo(roomVM.lastMessageID, anchor: .bottom)
                        }
                    } else {
                        roomVM.sendTypingStatus()
                    }
                }
            }
        }.rotationEffect(.radians(3.14))
        .padding(.top, 1)
    }
}
//
//struct MessagesList_Previews: PreviewProvider {
//    static var previews: some View {
//        MessagesList()
//    }
//}
