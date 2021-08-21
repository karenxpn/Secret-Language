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
    func sendVerificationCode( phoneNumber: String, birthday: String ) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never>
    func checkVerificationCode( token: String, phoneNumber: String, code: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func signUp( token: String, fullName: String, gender: Int, connectionType: Int ) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never>

    func fetchConnectionTypes() -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never>
    func fetchAllGenders() -> AnyPublisher<DataResponse<[GenderModel], NetworkError>, Never>
    
    //sign in
    
    func sendSignInVerificationCode( phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func checkSignInVerificationCode( phoneNumber: String, code: String ) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never>
    
    // global
    func resendVerificationCode(phoneNumber: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func logout( token: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class AuthService {
    static let shared: AuthServiceProtocol = AuthService()
    
    private init() { }
}

extension AuthService: AuthServiceProtocol {
    func logout(token: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/logout")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
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
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-in")!
        
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
    
    func checkSignInVerificationCode(phoneNumber: String, code: String) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-in/check-code")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "otp": code],
                          encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: AuthResponse.self)
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
    
    func sendVerificationCode(phoneNumber: String, birthday: String) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-up")!
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "birthday": birthday ],
                          encoder: JSONParameterEncoder.default)
            .validate()
            .publishDecodable(type: AuthResponse.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func checkVerificationCode(token: String, phoneNumber: String, code: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-up/check-code")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["phoneNumber": phoneNumber,
                                       "otp": code],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
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
    
    func signUp(token: String, fullName: String, gender: Int, connectionType: Int ) -> AnyPublisher<DataResponse<AuthResponse, NetworkError>, Never> {
        
        let model = SignUpRequest( name: fullName, gender: gender, interested_in: connectionType)
        let url = URL(string: "\(Credentials.BASE_URL)auth/sign-up/confirm")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]


        return AF.request(url,
                          method: .post,
                          parameters: model,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: AuthResponse.self)
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
