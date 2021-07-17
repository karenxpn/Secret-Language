//
//  MessageBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI

struct MessageBar: View {
    @EnvironmentObject var roomVM: MessageRoomViewModel

    var body: some View {
        
        HStack {
            
            Button(action: {
                
            }, label: {
                Image( systemName: "plus.circle")
                    .foregroundColor(.accentColor)
                    .font(.title)
                    .padding([.vertical, .leading])
            })
            
            HStack {
                TextField(NSLocalizedString("typeMessage", comment: ""),
                          text: $roomVM.messageText,
                          isEditing: $roomVM.writingMessage)
                    .foregroundColor(.gray)
                    .font(.custom("Gilroy_Regular", size: 15))

                Button {
                    
                } label: {
                    Image("send")
                }
                
            }.padding()
            .frame(width: .greedy, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(AppColors.messageBarBG)
            )
        }.padding(.trailing)
        .padding(.top, 8)
    }
}

struct MessageBar_Previews: PreviewProvider {
    static var previews: some View {
        MessageBar()
            .environmentObject(MessageRoomViewModel())
    }
}
