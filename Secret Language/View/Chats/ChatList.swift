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
                        .onAppear {
                            if chat.id == chatVM.chats[chatVM.chats.count-1].id {
                                chatVM.getChats()
                            }
                        }
                }
                
                if chatVM.loading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(AppColors.blueColor)
                }
                
                AllRightsReservedMadeByDoejo()
                    .padding(.top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .listRowInsets(EdgeInsets())
                    .background(AppColors.blueColor)

                
                if chatVM.chats.count > 4 {
                    Spacer().padding(.bottom, UIScreen.main.bounds.size.height * 0.2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .listRowInsets(EdgeInsets())
                        .background(AppColors.blueColor)
                }

        }.padding(.top, 1)
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList()
    }
}
