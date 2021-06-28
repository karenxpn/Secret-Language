//
//  SearchService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import Foundation
import Alamofire
import Combine

protocol SearchServiceProtocol {
    func fetchSearchedUsers( token: String, searchText: String, idealFor: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func fetchPopularUsers( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
}

class SearchService {
    static let shared = SearchService()
    
    private init() { }
}

extension SearchService: SearchServiceProtocol {
    
    func fetchPopularUsers(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        
        let url = URL(string: "\(Credentials.BASE_URL)user/popular")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: [UserPreviewModel].self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSearchedUsers( token: String, searchText: String, idealFor: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {

        let url = URL(string: "\(Credentials.BASE_URL)user/search")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]

        return AF.request(url,
                          method: .post,
                          parameters: [ "name" : searchText,
                                        "ideal" : idealFor],
                          headers: headers)
            .validate()
            .publishDecodable(type: [UserPreviewModel].self)
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
