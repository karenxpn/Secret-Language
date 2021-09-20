//
//  SingleMessageContent.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 17.07.21.
//

import SwiftUI
import AVKit

struct SingleMessageContent: View {
    @EnvironmentObject var roomVM: MessageRoomViewModel
    
    let message: Message
    let me: Bool
    
    var body: some View {
        if message.content.count == 1 {
            if message.content[0].type == "text" {
                Text(message.content[0].message)
                    .foregroundColor( me ? .white : .black)
                    .foregroundColor(.white)
                    .font(.custom("Gilroy-Regular", size: 16))
                    .lineLimit(nil)
                    .padding()
                    .background(me ? AppColors.sentMessageBoxBG : AppColors.accentColor)
                    .cornerRadius( me ? [.topLeading, .topTrailing, .bottomLeading]
                                    : [.topLeading, .topTrailing, .bottomTrailing], 20)
                    .onTapGesture {}
                    .onLongPressGesture {
                        roomVM.action = .message
                        roomVM.actionItem = message
                    }
            } else if message.content[0].type == "image" {
                MessageImageHelper(image: message.content[0].message,progressViewTintColor: .white)
                    .frame( width: UIScreen.main.bounds.size.width * 0.6,
                            height: UIScreen.main.bounds.size.height * 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .cornerRadius(8)
                    .padding()
                    .background(me ? AppColors.sentMessageBoxBG : AppColors.accentColor)
                    .cornerRadius( me ? [.topLeading, .topTrailing, .bottomLeading]
                                    : [.topLeading, .topTrailing, .bottomTrailing], 20)
                    .onTapGesture {
                        roomVM.imageMessage = message
                        roomVM.activeSheet = .media
                        roomVM.openSheet.toggle()
                    }
                    .onLongPressGesture {
                        roomVM.action = .message
                        roomVM.actionItem = message
                    }
            } else if message.content[0].type == "video" {
                let player = AVPlayer(url:  URL(string: message.content[0].message)!)
                
                VideoPlayer(player: player)
                    .frame( width: UIScreen.main.bounds.size.width * 0.6,
                            height: UIScreen.main.bounds.size.height * 0.5)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .scaledToFit()
                    .cornerRadius(8)
                    .padding()
                    .background(me ? AppColors.sentMessageBoxBG : AppColors.accentColor)
                    .cornerRadius( me ? [.topLeading, .topTrailing, .bottomLeading]
                                    : [.topLeading, .topTrailing, .bottomTrailing], 20)
                    .onAppear {
                        player.play()
                    }.onDisappear {
                        player.pause()
                    }
                    .onTapGesture {
                        roomVM.imageMessage = message
                        roomVM.activeSheet = .media
                        roomVM.openSheet.toggle()
                    }
                    .onLongPressGesture {
                        roomVM.action = .message
                        roomVM.actionItem = message
                    }
            } else if message.content[0].type == "audio" {
                //                SingleMessageAudio(message: message, me: me)
                //                    .environmentObject(roomVM)
            }
        }
    }
}
struct SingleMessageContent_Previews: PreviewProvider {
    static var previews: some View {
        SingleMessageContent(message: Message(id: 1, content: [ContentModel(message: "https://www.youtube.com/watch?v=zWh3CShX_do", type: "video")], user: MessageUserModel(id: 20, name: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png"), created_at: "1m ago", read: false), me: false).environmentObject(MessageRoomViewModel())
    }
}
