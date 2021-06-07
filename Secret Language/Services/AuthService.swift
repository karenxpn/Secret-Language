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
    
    func fetchConnectionTypes() -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never>
    func fetchAllGenders() -> AnyPublisher<DataResponse<[GenderModel], NetworkError>, Never>
    
    func sendSignInVerificationCode( phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func checkSignInVerificationCode( phoneNumber: String, code: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func signUp( phoneNumber: String, birthday: String, gender: Int, connectionType: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func resendVerificationCode(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class AuthService {
    static let shared = AuthService()
    
    private init() { }
}

extension AuthService: AuthServiceProtocol {
    func resendVerificationCode(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/resend-code")!
        
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
    
    func sendSignInVerificationCode(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/signin/send-code")!
        
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
    
    func checkSignInVerificationCode(phoneNumber: String, code: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/signin/check-code")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "verification-code": code],
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
    
    
    // sign up
    
    func fetchAllGenders() -> AnyPublisher<DataResponse<[GenderModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)genders")!
        
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
        let url = URL(string: "\(Credentials.BASE_URL)interests")!
        
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
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-up")!
        
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
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-up/check-code")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "otp": code],
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
    
    func signUp( phoneNumber: String, birthday: String, gender: Int, connectionType: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        
        let model = SignUpRequest(phoneNumber: phoneNumber, birthday: birthday, gender: gender, interested_in: connectionType)
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-up/confirm")!

        return AF.request(url,
                          method: .post,
                          parameters: model,
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
