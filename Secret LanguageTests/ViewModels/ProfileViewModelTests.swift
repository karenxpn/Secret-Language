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
    
    func testAddProfileImageWithError() {
        service.addImageToGalleryError = true
        viewModel.addProfileImage(image: Data(count: 0))
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testAddProfileImageWithSuccess() {
        service.addImageToGalleryError = false
        viewModel.addProfileImage(image: Data(count: 0))
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testRemoveProfileImageWithError() {
        service.removeImageFromGalleryError = true
        viewModel.removeProfileImage(id: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testRemoveProfileImageWithSuccess() {
        service.removeImageFromGalleryError = false
        viewModel.removeProfileImage(id: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testMakeImageAsAvatarWithError() {
        service.makeImageAvatarError = true
        viewModel.makeProfileImage(id: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testMakeImageAsAvatarWithSuccess() {
        service.makeImageAvatarError = false
        viewModel.makeProfileImage(id: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testGetProfileImageWithError() {
        service.fetchProfileImageGalleryError = true
        viewModel.getProfileImages()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.profileImages == nil )
    }
    
    func testGetProfileImagesWithSuccess() {
        service.fetchProfileImageGalleryError = false
        viewModel.getProfileImages()
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
}
