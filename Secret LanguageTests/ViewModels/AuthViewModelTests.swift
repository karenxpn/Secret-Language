//
//  AuthViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 01.06.21.
//

import XCTest
@testable import Secret_Language

class AuthViewModelTests: XCTestCase {

    
    var service: MockAuthService!
    var viewModel: AuthViewModel!
    
    override func setUp() {
        self.service = MockAuthService()
        self.viewModel = AuthViewModel(dataManager: self.service)
    }
    
    func testSendVerificationCodeWithError() {
        service.sendVerificationError = true
        viewModel.sendVerificationCode()
        
        XCTAssertFalse(viewModel.sendVerificationCodeAlertMessage.isEmpty)
    }
    
    func testSendVerificationCodeWithSuccess() {
        service.sendVerificationError = false
        viewModel.sendVerificationCode()
        
        XCTAssertTrue(viewModel.sendVerificationCodeAlertMessage.isEmpty)
    }
    
    func testCheckVerificationCodeWithError() {
        service.checkVerificationError = true
        viewModel.checkVerificationCode()
        
        XCTAssertFalse(viewModel.checkVerificationCodeAlertMessage.isEmpty)
    }
    
    func testCheckVerificationCodeWithSuccess() {
        service.checkVerificationError = false
        viewModel.checkVerificationCode()
        
        XCTAssertTrue(viewModel.checkVerificationCodeAlertMessage.isEmpty)
    }
    
    func testGetAllGendersWithError() {
        service.fetchAllGendersError = true
        viewModel.getAllGenders()
        
        XCTAssertTrue(viewModel.moreGenders.isEmpty)
    }
    
    func testGetAllGendersWithSuccess() {
        service.fetchAllGendersError = false
        viewModel.getAllGenders()
        
        XCTAssertFalse(viewModel.moreGenders.isEmpty)
    }
    
    func testGetConnectionTypesWithError() {
        service.fetchConnectionTypesError = true
        viewModel.getConnectionTypes()
        
        XCTAssertTrue(viewModel.connectionTypes.isEmpty)
    }
    
    func testGetConnectionTypesWithSuccess() {
        service.fetchConnectionTypesError = false
        viewModel.getConnectionTypes()
        
        XCTAssertFalse(viewModel.connectionTypes.isEmpty)
    }
    
    
    // sign in
    func testSendSignInVerificationCodeWithError() {
        service.sendSignInVerificatioCodeError = true
        viewModel.sendSignInVerificationCode()
        
        XCTAssertFalse(viewModel.sendVerificationCodeAlertMessage.isEmpty)
    }
    
    func testSendSignInVerificationCodeWithSuccess() {
        service.sendSignInVerificatioCodeError = false
        viewModel.sendSignInVerificationCode()
        
        XCTAssertTrue(viewModel.sendVerificationCodeAlertMessage.isEmpty)
    }
    
    func testCheckSignInVerificationCodeWithError() {
        service.checkSignInVerificationCodeError = true
        viewModel.checkSignInVerificationCode()
        
        XCTAssertFalse(viewModel.checkVerificationCodeAlertMessage.isEmpty)
    }
    
    func testCheckSignInVerificationCodeWithSuccess() {
        service.checkSignInVerificationCodeError = false
        viewModel.checkSignInVerificationCode()
        
        XCTAssertTrue(viewModel.checkVerificationCodeAlertMessage.isEmpty)
    }

}
