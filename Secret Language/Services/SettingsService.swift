//
//  SettingsService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import Foundation
import Alamofire
import Combine

protocol SettingsServiceProtocol {
    func fetchSettingsFields( token: String ) -> AnyPublisher<DataResponse<SettingsFields, NetworkError>, Never>
    func updateFields( token: String, parameters: SettingsFieldsUpdateModel ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class SettingsService {
    static let shared: SettingsServiceProtocol = SettingsService()
    
    private init() { }
}

extension SettingsService: SettingsServiceProtocol {
    func updateFields(token: String, parameters: SettingsFieldsUpdateModel) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/updateProfile")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
                
        return AF.request(url,
                          method: .patch,
                          parameters: parameters,
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
    
    func fetchSettingsFields(token: String) -> AnyPublisher<DataResponse<SettingsFields, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/settings")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: SettingsFields.self)
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
