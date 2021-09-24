//
//  MockFriendsService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 22.06.21.
//

import Foundation
import Alamofire
import Combine
import PusherSwift
@testable import Secret_Language

class MockProfileService: ProfileServiceProtocol {
    
    func deactivateAccount(token: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        
        let result = Result<GlobalResponse, NetworkError>.success(globalResponse)
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    
    func fetchProfileImageGallery(token: String) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        var result: Result<ProfileGalleryResponse, NetworkError>
        
        if fetchProfileImageGalleryError    { result = Result<ProfileGalleryResponse, NetworkError>.failure(networkError) }
        else                                { result = Result<ProfileGalleryResponse, NetworkError>.success(profileGalleryResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<ProfileGalleryResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func addProfileImageToGallery(token: String, image: Data) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        var result: Result<ProfileGalleryResponse, NetworkError>
        
        if addImageToGalleryError    { result = Result<ProfileGalleryResponse, NetworkError>.failure(networkError) }
        else                         { result = Result<ProfileGalleryResponse, NetworkError>.success(profileGalleryResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<ProfileGalleryResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func deleteProfileImageFromGallery(token: String, imageID: Int) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        var result: Result<ProfileGalleryResponse, NetworkError>
        
        if removeImageFromGalleryError      { result = Result<ProfileGalleryResponse, NetworkError>.failure(networkError) }
        else                                { result = Result<ProfileGalleryResponse, NetworkError>.success(profileGalleryResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<ProfileGalleryResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func makeProfileImage(token: String, imageID: Int) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        var result: Result<ProfileGalleryResponse, NetworkError>
        
        if makeImageAvatarError    { result = Result<ProfileGalleryResponse, NetworkError>.failure(networkError) }
        else                       { result = Result<ProfileGalleryResponse, NetworkError>.success(profileGalleryResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<ProfileGalleryResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    var reportUserError: Bool = false
    var blockUserError: Bool = false
    var flagUserError: Bool = false
    var fetchSharedProfileError: Bool = false
    
    let sharedProfile = SharedProfileModel(id: 1, name: "karen mirakyan", age: 21, images: [ProfileGalleryItem(id: 1, image: "")], user_birthday: "", user_birthday_name: "", sln: "", sln_description: "", report: "", advice: "", famous_years: "", distance: "", instagram: "karenmirakyan")
    let profileGalleryResponse = ProfileGalleryResponse(canAdd: true, avatar: ProfileGalleryItem(id: 1, image: ""), images: [ProfileGalleryItem(id: 2, image: "")])
    
    func reportUser(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if reportUserError { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else               { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func blockUser(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if blockUserError { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else               { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func flagUser(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if flagUserError { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else               { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchSharedProfile(userID: Int) -> AnyPublisher<DataResponse<SharedProfileModel, NetworkError>, Never> {
        var result: Result<SharedProfileModel, NetworkError>
        
        if fetchSharedProfileError  { result = Result<SharedProfileModel, NetworkError>.failure(networkError)}
        else                        { result = Result<SharedProfileModel, NetworkError>.success(sharedProfile)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<SharedProfileModel, NetworkError>, Never>( response )
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchFriendRequestsWithPusher(channel: PusherChannel, completion: @escaping ([UserPreviewModel]) -> ()) { }
    func fetchPendingRequestsWithPusher(channel: PusherChannel, completion: @escaping ([UserPreviewModel]) -> ()) { }
    func fetchProfileWithPusher(channel: PusherChannel, completion: @escaping (RequestsModel) -> ()) { }
    func fetchFriendsWithPusher(channel: PusherChannel, completion: @escaping ([UserPreviewModel]) -> ()) { }
    
    func acceptFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if acceptFriendRequestError { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                        { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func rejectFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if rejectFriendRequestError { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                        { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func withdrawFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if withdrawRequestError    { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                       { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchProfile(token: String) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never> {
        var result: Result<UserModel, NetworkError>
        
        if fetchProfileError    { result = Result<UserModel, NetworkError>.failure(networkError)}
        else                    { result = Result<UserModel, NetworkError>.success(profile)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<UserModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let users = [UserPreviewModel(id: 1, name: "John Smith", image: "", ideal: "Business")]
    let globalResponse = GlobalResponse(status: "success", message: "success" )
    let profile = UserModel(id: 1, image: "", name: "Karen Mirakyan", age: 21, friends: 3, pending: 3, requests: 3, birthday_report: PreviewParameters.birthdayReport)
    
    // friends
    var fetchFriendRequestsError: Bool = false
    var fetchFriendsError: Bool = false
    var fetchPendingRequestsError: Bool = false
    var withdrawRequestError: Bool = false
    var acceptFriendRequestError: Bool = false
    var rejectFriendRequestError: Bool = false
    
    // profile
    var fetchProfileError: Bool = false
    var fetchProfileImageGalleryError: Bool = false
    var addImageToGalleryError: Bool = false
    var removeImageFromGalleryError: Bool = false
    var makeImageAvatarError: Bool = false
    
    func fetchPendingRequests(token: String, page: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if fetchPendingRequestsError    { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                            { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchFriendRequests(token: String, page: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if fetchFriendRequestsError { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                        { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchFriends(token: String, page: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        var result: Result<[UserPreviewModel], NetworkError>
        
        if fetchFriendsError { result = Result<[UserPreviewModel], NetworkError>.failure(networkError)}
        else                 { result = Result<[UserPreviewModel], NetworkError>.success(users)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[UserPreviewModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
}
