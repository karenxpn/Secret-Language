//
//  SharedReportViewModelTests.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 13.10.21.
//

import XCTest
@testable import Secret_Language

class SharedReportViewModelTests: XCTestCase {

    var service: MockReportService!
    var viewModel: SharedReportViewModel!
    
    override func setUp() {
        self.service = MockReportService()
        self.viewModel = SharedReportViewModel(dataManager: self.service)
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
