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
        
        XCTAssertTrue(viewModel.navigate)
    }
    
    func testGetBirthdayReportWithError() {
        service.fetchBirthdayReportError = true
        viewModel.getBirthdayReport()
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetBirthdayReportWithSuccess() {
        service.fetchBirthdayReportError = false
        viewModel.getBirthdayReport()
        
        XCTAssertTrue(viewModel.navigate)
    }
    
    func testGetSharedBirthdayReportWithError() {
        service.fetchSharedBirthdayReportError = true
        viewModel.getSharedBirthdayReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetSharedBirthdayReportWithSuccess() {
        service.fetchSharedBirthdayReportError = false
        viewModel.getSharedBirthdayReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
    
    func testGetSharedRelationshipReportWithError() {
        service.fetchSharedRelationshipReportError = true
        viewModel.getSharedRelationshipReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
    }
    
    func testGetSharedRelationshipReportWithSuccess() {
        service.fetchSharedRelationshipReportError = false
        viewModel.getSharedRelationshipReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
    }
}
