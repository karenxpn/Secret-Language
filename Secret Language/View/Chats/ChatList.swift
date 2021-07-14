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
            ForEach(chats, id: \.id ) { chat in
                ChatListCell(chat: chat)
            }.listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(chats: [ChatModel(id: 1, chatName: "Karen Mirakyan", image: "", messageCount: 4, message: ChatPreveiwMessage(type: "text", content: [ContentModel(message: "hello", type: "text")], created_at: "1d ago"), read: false)])
    }
}
