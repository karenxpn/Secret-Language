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
    
    
    func testGetDayReportWithError() {
        service.fetchSharedDayReportError = true
        viewModel.getSharedDayReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.dayReport == nil)
    }
    
    func testGetDayReportWithSuccess() {
        service.fetchSharedDayReportError = false
        viewModel.getSharedDayReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertFalse(viewModel.dayReport == nil)
    }
    
    func testGetWeekReportWithError() {
        service.fetchSharedWeekReportError = true
        viewModel.getSharedWeekReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.weekReport == nil)
    }
    
    func testGetWeekReportWithSuccess() {
        service.fetchSharedWeekReportError = false
        viewModel.getSharedWeekReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertFalse(viewModel.weekReport == nil)
    }
    
    func testGetMonthReportWithError() {
        service.fetchSharedMonthReportError = true
        viewModel.getSharedMonthReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.monthReport == nil)
    }
    
    func testGetMonthReportWithSuccess() {
        service.fetchSharedMonthReportError = false
        viewModel.getSharedMonthReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertFalse(viewModel.monthReport == nil)
    }
    
    func testGetSeasonReportWithError() {
        service.fetchSharedSeasonReportError = true
        viewModel.getSharedSeasonReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.seasonReport == nil)
    }
    
    func testGetSeasonReportWithSuccess() {
        service.fetchSharedSeasonReportError = false
        viewModel.getSharedSeasonReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertFalse(viewModel.seasonReport == nil)
    }
    
    func testGetWayReportWithError() {
        service.fetchSharedWayReportError = true
        viewModel.getSharedWayReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.wayReport == nil)
    }
    
    func testGetWayReportWithSuccess() {
        service.fetchSharedWayReportError = false
        viewModel.getSharedWayReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertFalse(viewModel.wayReport == nil)
    }
    
    func testGetPathReportWithError() {
        service.fetchSharedPathReportError = true
        viewModel.getSharedPathReport(reportID: 1)
        
        XCTAssertFalse(viewModel.alertMessage.isEmpty)
        XCTAssertTrue(viewModel.pathReport == nil)
    }
    
    func testGetPathReportWithSuccess() {
        service.fetchSharedPathReportError = false
        viewModel.getSharedPathReport(reportID: 1)
        
        XCTAssertTrue(viewModel.alertMessage.isEmpty)
        XCTAssertFalse(viewModel.pathReport == nil)
    }
}
