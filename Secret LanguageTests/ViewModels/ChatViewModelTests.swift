//
//  ChatViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 15.07.21.
//

import XCTest
@testable import Secret_Language

class ChatViewModelTests: XCTestCase {

    var service: MockChatService!
    var viewModel: ChatViewModel!
    
    override func setUp() {
        self.service = MockChatService()
        self.viewModel = ChatViewModel(dataManager: self.service)
    }
    
    func testGetChatListWithError() {
        service.fetchChatListError = true
        viewModel.getChats()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }

    func testGetChatListWithSuccess() {
        service.fetchChatListError = false
        viewModel.getChats()
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
}
