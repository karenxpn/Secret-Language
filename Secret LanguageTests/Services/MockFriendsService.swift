//
//  MockFriendsService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 22.06.21.
//

import Foundation
import Alamofire
import Combine
@testable import Secret_Language

class MockFriendsService: FriendsServiceProtocol {
    
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let users = [UserPreviewModel(id: 1, name: "John Smith", image: "", ideal_for: "Business")]
    let friendsAndRequests = FriendsAndRequestsModel(friends: 12, pending: 12, requests: 12)
    
    var fetchFriendRequestsError: Bool = false
    var fetchFriendsError: Bool = false
    var fetchFriendsAndRequestsCountError: Bool = false
    
    func fetchFriendRequests(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if fetchFriendRequestsError { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                        { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchFriends(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if fetchFriendsError { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                 { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchFriendsAndRequestsCount(token: String) -> AnyPublisher<DataResponse<FriendsAndRequestsModel, NetworkError>, Never> {
        var result: Result<FriendsAndRequestsModel, NetworkError>
        
        if fetchFriendsAndRequestsCountError    { result = Result<FriendsAndRequestsModel, NetworkError>.failure(networkError)}
        else                                    { result = Result<FriendsAndRequestsModel, NetworkError>.success(friendsAndRequests)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<FriendsAndRequestsModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
}
