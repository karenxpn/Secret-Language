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
    var fetchSharedBirthdayReportError: Bool = false
    var fetchSharedRelationshipReportError: Bool = false
    
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
