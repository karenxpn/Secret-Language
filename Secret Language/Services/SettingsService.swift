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
    func fetchLocations( token: String, text: String ) -> AnyPublisher<DataResponse<[LocationListItemModel], NetworkError>, Never>
    func fetchSettingsFields( token: String ) -> AnyPublisher<DataResponse<SettingsFields, NetworkError>, Never>
    func updateFields( token: String, parameters: SettingsFieldsUpdateModel ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func updateLocation( token: String, id: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class SettingsService {
    static let shared: SettingsServiceProtocol = SettingsService()
    
    private init() { }
}

extension SettingsService: SettingsServiceProtocol {
    func updateLocation(token: String, id: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/updateUserLocation")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
                
        return AF.request(url,
                          method: .patch,
                          parameters: ["id" : id],
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
    
    func fetchLocations(token: String, text: String) -> AnyPublisher<DataResponse<[LocationListItemModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)cities/search")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["input" : text],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: [LocationListItemModel].self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
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
