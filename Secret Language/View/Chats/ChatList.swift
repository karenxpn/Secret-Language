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
        List{
            VStack( alignment: .leading, spacing: 20) {
                Text( NSLocalizedString("yourMessages", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("times", size: 26))
                    .fontWeight(.semibold)
                
                Text( NSLocalizedString("toStartCommunication", comment: ""))
                    .foregroundColor(AppColors.accentColor)
                    .font(.custom("Gilroy-Regular", size: 14))
            }.padding(.bottom)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            
            ForEach(chatVM.chats, id: \.id ) { chat in
                ChatListCell(chat: chat)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                    .onAppear(perform: {
                        if chat.id == chatVM.chats.last?.id && !chatVM.loading {
                            chatVM.getChats()
                        }
                    })
            }
            
            if chatVM.loading {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }.listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
            }
            
            AllRightsReservedMadeByDoejo()
                .padding([.top])
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            
            Spacer().padding(.bottom, UIScreen.main.bounds.size.height * 0.2)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets())
            
        }.padding(.top, 1)
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
