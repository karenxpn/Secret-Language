//
//  FriendsService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import Foundation
import Contacts
import Alamofire
import Combine
import PusherSwift

protocol ProfileServiceProtocol {
    func fetchFriendRequests( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func fetchFriendRequestsWithPusher( channel: PusherChannel, username: String, completion: @escaping ([UserPreviewModel]) -> () )
    func acceptFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func rejectFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    
    func fetchFriends( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func fetchFriendsWithPusher( channel: PusherChannel, username: String, completion: @escaping ([UserPreviewModel]) -> () )
    func withdrawFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchPendingRequests( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func fetchPendingRequestsWithPusher( channel: PusherChannel, username: String, completion: @escaping ([UserPreviewModel]) -> () )
    
    func fetchProfile( token: String ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never>
    func fetchProfileWithPusher( channel: PusherChannel, username: String, completion: @escaping ( UserModel ) -> () )
    
    
    func deleteProfileImage( token: String ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never>
    func updateProfileImage( token: String, image: Data ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never>
}

class ProfileService {
    static let shared = ProfileService()
    
    private init() { }
}

extension ProfileService: ProfileServiceProtocol {
    func fetchFriendRequestsWithPusher(channel: PusherChannel, username: String, completion: @escaping ([UserPreviewModel]) -> ()) {
        
        channel.bind(eventName: "myRequests", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    guard let requests = try? JSONDecoder().decode([UserPreviewModel].self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(requests)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
    func fetchFriendsWithPusher(channel: PusherChannel, username: String, completion: @escaping ([UserPreviewModel]) -> ()) {
        
        channel.bind(eventName: "myFriends", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    guard let friends = try? JSONDecoder().decode([UserPreviewModel].self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(friends)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
    func fetchPendingRequestsWithPusher(channel: PusherChannel, username: String, completion: @escaping ([UserPreviewModel]) -> ()) {
        
        channel.bind(eventName: "pendingRequests", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    guard let requests = try? JSONDecoder().decode([UserPreviewModel].self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(requests)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
    func fetchProfileWithPusher(channel: PusherChannel, username: String, completion: @escaping (UserModel) -> ()) {
        
        channel.bind(eventName: "getMe", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    guard let profile = try? JSONDecoder().decode(UserModel.self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(profile)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
    
    // pending requests
    func withdrawFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/withdrawFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
                          encoder: JSONParameterEncoder.default,
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
    
    func fetchPendingRequests(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/pendingRequests")!
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
    // pending requests end
    
    
    // friend requests
    func fetchFriendRequests(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/myRequests")!
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
    
    func acceptFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/acceptFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
                          encoder: JSONParameterEncoder.default,
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
    
    func rejectFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/rejectFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
                          encoder: JSONParameterEncoder.default,
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
    // friend requests end
    
    // friends
    func fetchFriends(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/myFriends")!
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
    } // end friends
    
    // profile
    func fetchProfile(token: String) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/me")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: UserModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func deleteProfileImage(token: String) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/removeAvatar")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .delete,
                          headers: headers)
            .validate()
            .publishDecodable(type: UserModel.self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func updateProfileImage(token: String, image: Data ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/addAvatar")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Content-type": "multipart/form-data"]
        
        
        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            multipartFormData.append(image, withName: "image", fileName: "\(UUID().uuidString).jpeg" ,mimeType: "image/jpeg")
        }, to: url,
        method: .post,
        headers: headers)
        .validate()
        .publishDecodable(type: UserModel.self)
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
