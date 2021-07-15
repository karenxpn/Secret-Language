//
//  MessageRoomViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.07.21.
//

import Foundation
import SwiftUI
import Combine

class MessageRoomViewModel: ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    @Published var messageText: String = ""
    @Published var writingMessage: Bool = false
    @Published var loadingMessages: Bool = false
    @Published var messages = [Message]()
    
    @Published var lastMessageID: Int = 0
    
    func getChatRoomMessages( lastMessageID: Int ) {
        
    }
    
    func sendTypingStatus() {
        
    }
    
    
}
