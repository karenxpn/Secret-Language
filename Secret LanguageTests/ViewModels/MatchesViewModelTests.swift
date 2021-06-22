//
//  MatchesViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 16.06.21.
//

import XCTest
@testable import Secret_Language

class MatchesViewModelTests: XCTestCase {

    
    var service: MockMatchService!
    var viewModel: MatchesViewModel!
    
    override func setUp() {
        self.service = MockMatchService()
        self.viewModel = MatchesViewModel(dataManager: self.service)
    }
    
    func testGetMatchesWithError() {
        service.fetchMatchesError = true
        viewModel.getMatches()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetMatchesWithSuccess() {
        service.fetchMatchesError = false
        viewModel.getMatches()
        
        XCTAssertFalse(viewModel.matches.isEmpty)
    }

}
