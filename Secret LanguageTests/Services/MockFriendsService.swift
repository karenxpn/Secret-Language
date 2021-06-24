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
    func acceptFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if acceptFriendRequestError { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                        { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func rejectFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if rejectFriendRequestError { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                        { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func withdrawFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if withdrawRequestError    { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                       { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchPendingRequests(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if fetchPendingRequestsError    { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                            { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchContacts(completion: @escaping ([ContactRequestModel]) -> ()) {
    }
    
    func postContacts(contacts: [ContactRequestModel], token: String) -> AnyPublisher<DataResponse<[ContactResponseModel], NetworkError>, Never> {
        
        var result: Result<[ContactResponseModel], NetworkError>
        
        if postContactsError    { result = Result<[ContactResponseModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[ContactResponseModel], NetworkError>.success(self.contacts)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[ContactResponseModel], NetworkError>, Never>( response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchContacts(token: String) -> AnyPublisher<DataResponse<[ContactResponseModel], NetworkError>, Never> {
        var result: Result<[ContactResponseModel], NetworkError>
        
        if fetchContactError    { result = Result<[ContactResponseModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[ContactResponseModel], NetworkError>.success(contacts)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[ContactResponseModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let users = [UserPreviewModel(id: 1, name: "John Smith", image: "", ideal: "Business")]
    let friendsAndRequests = FriendsAndRequestsModel(friends: 12, pending: 12, requests: 12)
    let contacts = [ContactResponseModel(id: 1, firstName: "Karen", lastName: "Mirakyan", phone: "+37493936313", image: nil, invited: false)]
    
    var fetchFriendRequestsError: Bool = false
    var fetchFriendsError: Bool = false
    var fetchFriendsAndRequestsCountError: Bool = false
    var fetchContactError: Bool = false
    var postContactsError: Bool = false
    var fetchPendingRequestsError: Bool = false
    var withdrawRequestError: Bool = false
    var acceptFriendRequestError: Bool = false
    var rejectFriendRequestError: Bool = false
    
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
