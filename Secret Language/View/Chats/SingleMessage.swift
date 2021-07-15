//
//  SingleMessage.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import SwiftUI

struct SingleMessage: View {
    @EnvironmentObject var roomVM: MessageRoomViewModel
    let message: Message
    
    var body: some View {
        Text(message.content[0].message)
    }
}

//struct SingleMessage_Previews: PreviewProvider {
//    static var previews: some View {
//        SingleMessage()
//    }
//}
