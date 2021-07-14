//
//  SearchService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import Foundation
import Alamofire
import PusherSwift
import Combine

protocol SearchServiceProtocol {
    func fetchSearchedUsers( token: String, searchText: String, idealFor: Int ) -> AnyPublisher<DataResponse<[SearchUserModel], NetworkError>, Never>
    func fetchPopularUsers( token: String, interestedIn: Int ) -> AnyPublisher<DataResponse<[SearchUserModel], NetworkError>, Never>
}

class SearchService {
    static let shared: SearchServiceProtocol = SearchService()
    
    private init() { }
}

extension SearchService: SearchServiceProtocol {
    
    func fetchPopularUsers(token: String, interestedIn: Int ) -> AnyPublisher<DataResponse<[SearchUserModel], NetworkError>, Never> {
        
        let url = URL(string: "\(Credentials.BASE_URL)user/getSuggestions")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        return AF.request(url,
                          method: .post,
                          parameters: ["interestedIn" : interestedIn],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: [SearchUserModel].self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSearchedUsers( token: String, searchText: String, idealFor: Int ) -> AnyPublisher<DataResponse<[SearchUserModel], NetworkError>, Never> {

        let url = URL(string: "\(Credentials.BASE_URL)user/searchAllUsers")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        return AF.request(url,
                          method: .post,
                          parameters: [ "input" : searchText],
                          headers: headers)
            .validate()
            .publishDecodable(type: [SearchUserModel].self)
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
