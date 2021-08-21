//
//  ChatRoomNavBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI

struct ChatRoomNavBar: View {
    @Binding var navigate: Bool
    let user: ChatUserModel
    
    var body: some View {
        
        Button {
            UIApplication.shared.endEditing()
            navigate.toggle()
        } label: {
            VStack {
                Text( "\(user.name), \(user.age)" )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 16))
                    .fontWeight(.semibold)
                
                HStack( spacing: 0 ) {
                    Text( NSLocalizedString("idealFor", comment: ""))
                        .foregroundColor(.gray)
                        .font(.custom("Avenir", size: 10))
                    
                    Text(user.ideal_for)
                        .foregroundColor(.accentColor)
                        .font(.custom("Avenir", size: 10))
                }
            }
        }
    }
}

struct ChatRoomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        ChatRoomNavBar(navigate: .constant(false), user: ChatUserModel(id: 2, name: "Karen Mirakyan", image: "", ideal_for: "Business", age: 21))
    }
}
