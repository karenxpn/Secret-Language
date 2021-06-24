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

protocol ProfileServiceProtocol {
    func fetchFriendRequests( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func acceptFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func rejectFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    
    func fetchFriends( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func withdrawFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchPendingRequests( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchProfile( token: String ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never>
    func deleteProfileImage( token: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func updateProfileImage( token: String, image: Data ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class ProfileService {
    static let shared = ProfileService()
    
    private init() { }
}

extension ProfileService: ProfileServiceProtocol {
    
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
        let url = URL(string: "\(Credentials.BASE_URL)user/getMe")!
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
    
    func deleteProfileImage(token: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/profile-image")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .delete,
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
    
    func updateProfileImage(token: String, image: Data ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/profile-image")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Content-type": "multipart/form-data"]
        
        
        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            multipartFormData.append(image, withName: "profile_image", fileName: "\(UUID().uuidString).jpeg" ,mimeType: "image/jpeg")
        }, to: url,
        method: .post,
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
    
}
