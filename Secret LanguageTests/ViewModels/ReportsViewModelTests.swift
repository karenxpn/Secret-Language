//
//  ReportsViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 03.07.21.
//

import XCTest
@testable import Secret_Language

class ReportsViewModelTests: XCTestCase {

    var service: MockReportService!
    var viewModel: ReportViewModel!
    
    override func setUp() {
        self.service = MockReportService()
        self.viewModel = ReportViewModel(dataManager: self.service)
    }
    
    func testGetRelationshipReportWithError() {
        service.fetchRelationshipReportError = true
        viewModel.getRelationshipReport()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }

    func testGetRelationshipReportWithSuccess() {
        service.fetchRelationshipReportError = false
        viewModel.getRelationshipReport()
        
        XCTAssertTrue(viewModel.navigateToRelationshipReport)
    }
}
