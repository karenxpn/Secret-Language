//
//  MockReportService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 03.07.21.
//

import Foundation
@testable import Secret_Language
import Alamofire
import Combine

class MockReportService: ReportServiceProtocol {
    
    var fetchSharedBirthdayReportError: Bool = false
    var fetchSharedRelationshipReportError: Bool = false
    var fetchSharedDayReportError: Bool = false
    var fetchSharedWeekReportError: Bool = false
    var fetchSharedMonthReportError: Bool = false
    var fetchSharedSeasonReportError: Bool = false
    var fetchSharedWayReportError: Bool = false
    var fetchSharedPathReportError: Bool = false
    
    func fetchSharedDayReport(reportID: Int) -> AnyPublisher<DataResponse<DayReportModel, NetworkError>, Never> {
        var result: Result<DayReportModel, NetworkError>
        
        if fetchSharedDayReportError    { result = Result<DayReportModel, NetworkError>.failure(networkError)}
        else                            { result = Result<DayReportModel, NetworkError>.success(PreviewParameters.dayReport)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<DayReportModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedWeekReport(reportID: Int) -> AnyPublisher<DataResponse<WeekReportModel, NetworkError>, Never> {
        var result: Result<WeekReportModel, NetworkError>
        
        if fetchSharedWeekReportError   { result = Result<WeekReportModel, NetworkError>.failure(networkError)}
        else                            { result = Result<WeekReportModel, NetworkError>.success(PreviewParameters.weekReport)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<WeekReportModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedMonthReport(reportID: Int) -> AnyPublisher<DataResponse<MonthReportModel, NetworkError>, Never> {
        var result: Result<MonthReportModel, NetworkError>
        
        if fetchSharedMonthReportError   { result = Result<MonthReportModel, NetworkError>.failure(networkError)}
        else                            { result = Result<MonthReportModel, NetworkError>.success(PreviewParameters.monthReport)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<MonthReportModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedSeasonReport(reportID: Int) -> AnyPublisher<DataResponse<SeasonReportModel, NetworkError>, Never> {
        var result: Result<SeasonReportModel, NetworkError>
        
        if fetchSharedSeasonReportError   { result = Result<SeasonReportModel, NetworkError>.failure(networkError)}
        else                              { result = Result<SeasonReportModel, NetworkError>.success(PreviewParameters.seasonReport)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<SeasonReportModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedWayReport(reportID: Int) -> AnyPublisher<DataResponse<WayReportModel, NetworkError>, Never> {
        var result: Result<WayReportModel, NetworkError>
        
        if fetchSharedWayReportError   { result = Result<WayReportModel, NetworkError>.failure(networkError)}
        else                           { result = Result<WayReportModel, NetworkError>.success(PreviewParameters.wayReport)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<WayReportModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedPathReport(reportID: Int) -> AnyPublisher<DataResponse<PathReportModel, NetworkError>, Never> {
        var result: Result<PathReportModel, NetworkError>
        
        if fetchSharedPathReportError   { result = Result<PathReportModel, NetworkError>.failure(networkError)}
        else                           { result = Result<PathReportModel, NetworkError>.success(PreviewParameters.pathReport)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<PathReportModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedBirthdayReport(reportID: Int) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never> {
        var result: Result<BirthdayReportModel, NetworkError>
        
        if fetchSharedBirthdayReportError   { result = Result<BirthdayReportModel, NetworkError>.failure(networkError)}
        else                                { result = Result<BirthdayReportModel, NetworkError>.success(birthdayModel)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<BirthdayReportModel, NetworkError>, Never>( response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedRelationshipReport(reportID: Int) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never> {
        var result: Result<RelationshipReportModel, NetworkError>
        
        if fetchSharedRelationshipReportError   { result = Result<RelationshipReportModel, NetworkError>.failure(networkError)}
        else                                    { result = Result<RelationshipReportModel, NetworkError>.success(relationshipModel)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<RelationshipReportModel, NetworkError>, Never>( response )
        return publisher.eraseToAnyPublisher()
    }
    
    var fetchBirthdayReportError: Bool = false
    var fetchRelationshipReportError: Bool = false
    
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let globalResponse = GlobalResponse(status: "success", message: "paid")
    let birthdayModel = PreviewParameters.birthdayReport
    let relationshipModel = PreviewParameters.relationshipReport
    
    func fetchBirthdayReport(token: String, date: String) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never> {
        var result: Result<BirthdayReportModel, NetworkError>
        
        if fetchBirthdayReportError { result = Result<BirthdayReportModel, NetworkError>.failure(networkError)}
        else                        { result = Result<BirthdayReportModel, NetworkError>.success(birthdayModel)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<BirthdayReportModel, NetworkError>, Never>( response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchRelationshipReport(token: String, firstDate: String, secondDate: String) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never> {
        var result: Result<RelationshipReportModel, NetworkError>
        
        if fetchRelationshipReportError { result = Result<RelationshipReportModel, NetworkError>.failure(networkError)}
        else                            { result = Result<RelationshipReportModel, NetworkError>.success(relationshipModel)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<RelationshipReportModel, NetworkError>, Never>( response )
        return publisher.eraseToAnyPublisher()
    }
}
