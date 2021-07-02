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
    
    func testCheckBirthdayReportStatusWithError() {
        service.checkBirthdayReportStatusError = true
        viewModel.checkBirthdayReport()
        
        XCTAssertFalse(viewModel.navigateToReport)
    }
    
    func testCheckBirthdayReportStatusWithSuccess() {
        service.checkBirthdayReportStatusError = false
        viewModel.checkBirthdayReport()
        
        XCTAssertTrue(viewModel.navigateToReport)
    }
    
    func testCheckRelationshipReportStatucWithError() {
        service.checkRelationshipReportStatusError = true
        viewModel.checkRelationshipReport()
        
        XCTAssertFalse(viewModel.navigateToReport)
    }
    
    func testCheckRelationshipReportStatusWithSuccess() {
        service.checkRelationshipReportStatusError = false
        viewModel.checkRelationshipReport()
        
        XCTAssertTrue(viewModel.navigateToReport)
    }

}
