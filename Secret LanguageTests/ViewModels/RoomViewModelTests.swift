//
//  RoomViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 24.07.21.
//

import XCTest
@testable import Secret_Language

class RoomViewModelTests: XCTestCase {

    var service: MockChatService!
    var viewModel: MessageRoomViewModel!
    
    override func setUp() {
        self.service = MockChatService()
        self.viewModel = MessageRoomViewModel(dataManager: self.service)
    }

    
    func testGetRoomMessagesWithError() {
        service.fetchRoomMessagesError = true
        viewModel.getChatRoomMessages(lastMessageID: 0)
        
        XCTAssertTrue(viewModel.messages.isEmpty)
    }
    
    func testGetRoomMessagesWithSuccess() {
        service.fetchRoomMessagesError = false
        viewModel.getChatRoomMessages(lastMessageID: 0)
        
        XCTAssertFalse(viewModel.messages.isEmpty)
    }
}
