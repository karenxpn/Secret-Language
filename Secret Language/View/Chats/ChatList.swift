//
//  ChatList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import SwiftUI

struct ChatList: View {
    
    let chats: [ChatModel]
    
    
    var body: some View {
        List {
            
            VStack( alignment: .leading, spacing: 20) {
                Text( NSLocalizedString("yourMessages", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .fontWeight(.semibold)

                Text( NSLocalizedString("toStartCommunication", comment: ""))
                    .foregroundColor(.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
            }.padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .listRowInsets(EdgeInsets())
            .background(AppColors.blueColor)

            ForEach(chats, id: \.id ) { chat in
                ChatListCell(chat: chat)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(AppColors.blueColor)
            }
        }.padding(.top, 1)
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(chats: [ChatModel(id: 1, chatName: "Karen Mirakyan", image: "", messageCount: 4, message: ChatPreveiwMessage(type: "text", content: [ContentModel(message: "hello", type: "text")], created_at: "1d ago"), read: false)])
    }
}
