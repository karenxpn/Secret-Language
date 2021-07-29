//
//  ChatList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import SwiftUI

struct ChatList: View {
    
    @EnvironmentObject var chatVM: ChatViewModel
    
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

            ForEach(chatVM.chats, id: \.id ) { chat in
                ChatListCell(chat: chat)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(AppColors.blueColor)
            }.onDelete(perform: delete)
        }.padding(.top, 1)
    }
    
    func delete(at offsets: IndexSet) {
        if let removeIndex = offsets.first {
            chatVM.deleteChat(index: removeIndex)
            chatVM.chats.remove(at: removeIndex)
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
