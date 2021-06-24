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
    
    func testGetPendingRequestsWithError() {
        service.fetchPendingRequestsError = true
        viewModel.getPendingRequests()
        
        XCTAssertTrue(viewModel.pendingList.isEmpty)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetPendingRequestsWithSuccess() {
        service.fetchPendingRequestsError = false
        viewModel.getPendingRequests()
        
        XCTAssertEqual(viewModel.pendingList.count, 1)
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
    
    func testAcceptFriendRequestWithError() {
        service.acceptFriendRequestError = true
        viewModel.acceptFriendRequest(userID: 1)
        
        XCTAssertTrue(viewModel.requestsList.isEmpty)
    }
    
    func testAcceptFriendRequestWithSuccess() {
        service.acceptFriendRequestError = false
        viewModel.acceptFriendRequest(userID: 1)
        
        XCTAssertEqual(viewModel.requestsList.count, 1)
    }
    
    func testRejectFriendRequestWithError() {
        service.rejectFriendRequestError = true
        viewModel.rejectFriendRequest(userID: 1)
        
        XCTAssertTrue(viewModel.requestsList.isEmpty)
    }
    
    func testRejectFriendRequestWithSuccess() {
        service.rejectFriendRequestError = false
        viewModel.rejectFriendRequest(userID: 1)
        
        XCTAssertEqual(viewModel.requestsList.count, 1)
    }
    
    func testWithdrawRequestWithError() {
        service.withdrawRequestError = true
        viewModel.withdrawFriendRequest(userID: 1)
        
        XCTAssertTrue(viewModel.pendingList.isEmpty)
    }
    
    func testWithdrawRequestWithSuccess() {
        service.withdrawRequestError = false
        viewModel.withdrawFriendRequest(userID: 1)
        
        XCTAssertEqual(viewModel.pendingList.count, 1)
    }

}
