//
//  SingleMessage.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleMessage: View {
    @EnvironmentObject var roomVM: MessageRoomViewModel
    @AppStorage( "userID" ) private var userID: Int = 0
    let message: Message
    
    var body: some View {
        
        if 20 != message.sender.id {
            // this means that the sender is me
            HStack( alignment: .bottom) {
                
                
                HStack( alignment: .top) {
                                        
                    ImageHelper(image: message.sender.image, contentMode: .fill, progressViewTintColor: .gray)
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                        .padding(.top, 6)
                    
                    SingleMessageContent(message: message, me: false)
                        .environmentObject(roomVM)
                }
                
                Text( message.created_at )
                    .foregroundColor(.gray)
                    .font(.custom("Gilroy-Regular", size: 16))
                
                Spacer()
            }


        } else {
            
            HStack( alignment: .bottom) {
                
                Spacer()
                
                Text( message.created_at )
                    .foregroundColor(.gray)
                    .font(.custom("Gilroy-Regular", size: 16))
                
                HStack( alignment: .top) {
                    
                    // here should be content
                    SingleMessageContent(message: message, me: true)
                        .environmentObject(roomVM)

                    ImageHelper(image: message.sender.image, contentMode: .fill, progressViewTintColor: .gray)
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                        .padding(.top, 6)
                }
            }
        }
    }
}

struct SingleMessage_Previews: PreviewProvider {
    static var previews: some View {
        SingleMessage( message: Message(id: 1, content: [ContentModel(message: "Hello, how are you? \ncan we meet today in the evening? ", type: "text")], sender: ChatUserModel(id: 18, name: "Karen Mirakyan", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business", age: 21), created_at: "1m ago", read: false))
            .environmentObject(MessageRoomViewModel())
    }
}
