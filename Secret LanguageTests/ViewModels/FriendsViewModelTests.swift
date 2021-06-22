//
//  FriendsViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 22.06.21.
//

import XCTest
@testable import Secret_Language

class FriendsViewModelTests: XCTestCase {

    var service: MockFriendsService!
    var viewModel: FriendsViewModel!
    
    override func setUp() {
        self.service = MockFriendsService()
        self.viewModel = FriendsViewModel(dataManager: self.service)
    }
    
    func testGetFriendsWithError() {
        service.fetchFriendsError = true
        viewModel.getFriends()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetFriendsWithSuccess() {
        service.fetchFriendsError = false
        viewModel.getFriends()
        
        XCTAssertTrue(!viewModel.friendsList.isEmpty)
    }
    
    func testGetFriendRequestsWithError() {
        service.fetchFriendRequestsError = true
        viewModel.getFriendRequests()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetFriendRequestsWithSuccess() {
        service.fetchFriendRequestsError = false
        viewModel.getFriendRequests()
        
        XCTAssertTrue(!viewModel.requestsList.isEmpty)
    }
    
    func testgetCountWithError() {
        service.fetchFriendsAndRequestsCountError = true
        viewModel.getCounts()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testgetCountWithSuccess() {
        service.fetchFriendsAndRequestsCountError = false
        viewModel.getCounts()
        
        XCTAssertEqual(viewModel.friendsCount, 12)
    }

}
