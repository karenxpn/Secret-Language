//
//  MessagesList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI
import ActivityIndicatorView

struct MessagesList: View {
    
    @EnvironmentObject var roomVM: MessageRoomViewModel
    let roomID: Int
    let username: String
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ScrollViewReader { scrollView in
                
                LazyVStack(spacing: 15) {
                    
                    if roomVM.senderIsTyping {
                        // show typing status
                        VStack {
                            Text( "\(username) is typing" )
                                .foregroundColor(.white)
                                .font(.custom("times", size: 15))

                            ActivityIndicatorView(isVisible: $roomVM.senderIsTyping, type: .scalingDots)
                                .foregroundColor(AppColors.accentColor)
                                .frame(width: 40, height: 15)
                        }.rotationEffect(.radians(3.14))
                    }
                    
                    ForEach(roomVM.messages, id: \.id) { message in
                        SingleMessage(message: message)
                            .environmentObject(roomVM)
                            .rotationEffect(.radians(3.14))
                            .onAppear {
                                if message.id == roomVM.messages.last?.id {
                                    roomVM.getChatRoomMessages(lastMessageID: message.id)
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

struct MessagesList_Previews: PreviewProvider {
    static var previews: some View {
        MessagesList(roomID: 1, username: "Karen Mirakyan")
            .environmentObject(MessageRoomViewModel())
    }
}
