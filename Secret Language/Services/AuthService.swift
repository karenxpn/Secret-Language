//
//  AuthService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import Foundation
import Combine
import Alamofire

protocol AuthServiceProtocol {
    func sendVerificationCode( phoneNumber: String, birthday: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func checkVerificationCode( phoneNumber: String, code: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func login( phoneNumber: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func fetchConnectionTypes() -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never>
    func fetchAllGenders() -> AnyPublisher<DataResponse<[GenderModel], NetworkError>, Never>
}

class AuthService {
    static let shared = AuthService()
    
    private init() { }
}

extension AuthService: AuthServiceProtocol {
    func fetchAllGenders() -> AnyPublisher<DataResponse<[GenderModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/connection-types")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: [GenderModel].self )
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchConnectionTypes() -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/connection-types")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: [ConnectionTypeModel].self )
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func sendVerificationCode(phoneNumber: String, birthday: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/send-code")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "birthday": birthday ],
                          encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: GlobalResponse.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func checkVerificationCode(phoneNumber: String, code: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/verify-reset-code")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "reset_code": code],
                          encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: GlobalResponse.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func login(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/singin")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber],
                          encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: GlobalResponse.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
