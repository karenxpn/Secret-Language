//
//  MatchService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.06.21.
//

import Foundation
import Alamofire
import Combine

protocol MatchServiceProtocol {
    func fetchMatches( token: String, params: GetMatchesRequest ) -> AnyPublisher<DataResponse<[MatchModel], NetworkError>, Never>
    func fetchCategories( token: String ) -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never>
    func fetchAllCategoryItems( token: String ) -> AnyPublisher<DataResponse<[CategoryItemModel], NetworkError>, Never>
    func sendLocation( token: String, location: Location) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func removeFromMatches( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func sendFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class MatchService {
    static let shared = MatchService()
    
    private init() { }
}

extension MatchService: MatchServiceProtocol {
    func sendFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/sendFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    
    func removeFromMatches(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/addSwipeLeftUser")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    

    func sendLocation(token: String, location: Location) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/addUserLocation")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: location,
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
    
    func fetchCategories(token: String) -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)interests")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: [ConnectionTypeModel].self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchAllCategoryItems(token: String) -> AnyPublisher<DataResponse<[CategoryItemModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)relationship/getIdealForTags")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: [CategoryItemModel].self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchMatches(token: String, params: GetMatchesRequest) -> AnyPublisher<DataResponse<[MatchModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/searchUsers")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: params,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: [MatchModel].self)
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
