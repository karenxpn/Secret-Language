//
//  ChatListCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatListCell: View {
    
    let chat: ChatModel
    @State private var isActive: Bool = false
    
    var body: some View {
        Button {
            isActive.toggle()
        } label: {
            
            VStack {
                HStack {
                    ImageHelper(image: chat.image, contentMode: .fill, progressViewTintColor: .gray)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .padding(.trailing)
                    
                    VStack( alignment: .leading, spacing: 5) {
                        Text( chat.chatName )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 20))
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        
                        if chat.message != nil {
                            Text( chat.message!.created_at)
                                .foregroundColor(.gray)
                                .font(.custom("Gilroy-Regular", size: 12))
                            
                            Text( chat.message!.content[0].message)
                                .foregroundColor(.gray)
                                .font(.custom("Gilroy-Regular", size: 15))
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    if !chat.read {
                        Text( "\(chat.messageCount)" )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 17))
                            .padding()
                            .background(
                                Circle().fill(Color.accentColor)
                                    .frame(width: 25, height: 25))
                    }
                }
                
                Capsule()
                    .fill(Color.gray)
                    .frame(width: .greedy, height: 0.5)
                
            }.padding([.top, .horizontal])
        }.buttonStyle(BorderlessButtonStyle())
        .background(
            NavigationLink( destination: ChatRoom(roomID: chat.id, user: chat.user), isActive: $isActive, label: {
                EmptyView()
            }).hidden()
        )
        
    }
}

struct ChatListCell_Previews: PreviewProvider {
    static var previews: some View {
        ChatListCell(chat: PreviewParameters.chatList[0])
    }
}
