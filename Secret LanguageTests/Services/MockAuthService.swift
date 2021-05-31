//
//  MockAuthService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 01.06.21.
//

import Foundation
import Alamofire
import Combine
@testable import Secret_Language

class MockAuthService: AuthServiceProtocol {
    
    let globalResponse = GlobalResponse(status: "success", message: "Success")
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    var sendVerificationError: Bool = false
    var checkVerificationError: Bool = false
    var loginError: Bool = false
    
    func sendVerificationCode(phoneNumber: String, birthday: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if sendVerificationError    { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                        { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(dataResponse)
        return publisher.eraseToAnyPublisher()
    }
    
    func checkVerificationCode(phoneNumber: String, code: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if checkVerificationError   { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                        { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(dataResponse)
        return publisher.eraseToAnyPublisher()
    }
    
    func login(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if loginError   { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else            { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(dataResponse)
        return publisher.eraseToAnyPublisher()
    }
}
