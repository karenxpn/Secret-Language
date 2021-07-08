//
//  FriendsViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 22.06.21.
//

import XCTest
@testable import Secret_Language

class ProfileViewModelTests: XCTestCase {

    var service: MockProfileService!
    var viewModel: ProfileViewModel!
    
    override func setUp() {
        self.service = MockProfileService()
        self.viewModel = ProfileViewModel(dataManager: self.service)
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

    func testGetProfileWithError() {
        service.fetchProfileError = true
        viewModel.getProfile()
        
        XCTAssertTrue(viewModel.profile == nil)
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetProfileWithSuccess() {
        service.fetchProfileError = false
        viewModel.getProfile()
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.profile != nil)
    }
    
    func testUpdateProfileImageWithError() {
        service.updateProfileImageError = true
        viewModel.updateProfileImage(image: Data(count: 0))
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testUpdateProfileImageWithSuccess() {
        service.updateProfileImageError = false
        viewModel.updateProfileImage(image: Data(count: 0))
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testDeleteProfileImageWithError() {
        service.deleteProfileImageError = true
        viewModel.deleteProfileImage()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testDeleteProfileImageWithSuccess() {
        service.deleteProfileImageError = false
        viewModel.deleteProfileImage()
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
}
