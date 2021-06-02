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
    func sendSignInVerificationCode(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if sendSignInVerificatioCodeError       { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                                    { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(dataResponse)
        return publisher.eraseToAnyPublisher()
    }
    
    func checkSignInVerificationCode(phoneNumber: String, code: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if checkSignInVerificationCodeError     { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                                    { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let dataResponse = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(dataResponse)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchConnectionTypes() -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never> {
        var result: Result<[ConnectionTypeModel], NetworkError>
        
        if fetchConnectionTypesError    { result = Result<[ConnectionTypeModel], NetworkError>.failure(networkError)}
        else                            { result = Result<[ConnectionTypeModel], NetworkError>.success(connectionTypes)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[ConnectionTypeModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchAllGenders() -> AnyPublisher<DataResponse<[GenderModel], NetworkError>, Never> {
        var result: Result<[GenderModel], NetworkError>
        
        if fetchAllGendersError { result = Result<[GenderModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[GenderModel], NetworkError>.success(genders)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[GenderModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    
    let globalResponse = GlobalResponse(status: "success", message: "Success")
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let genders = [GenderModel(id: 1, gender: "Male"), GenderModel(id: 2, gender: "Female")]
    let connectionTypes = [ConnectionTypeModel(id: 1, type: "Business", description: "desctiption")]
    
    var fetchConnectionTypesError: Bool = false
    var fetchAllGendersError: Bool = false
    var sendVerificationError: Bool = false
    var checkVerificationError: Bool = false
    var sendSignInVerificatioCodeError: Bool = false
    var checkSignInVerificationCodeError: Bool = false
    
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
}
