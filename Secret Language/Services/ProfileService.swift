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
    func fetchFriendRequests( token: String, page: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func acceptFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func rejectFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    
    func fetchFriends( token: String, page: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func withdrawFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func fetchPendingRequests( token: String, page: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchProfile( token: String ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never>
    func fetchProfileWithPusher( channel: PusherChannel, completion: @escaping ( UserModel ) -> () )
    
    func reportUser( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func blockUser( token: String, userID: Int ) ->  AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func flagUser( token: String, userID: Int ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    
    func fetchSharedProfile( userID: Int ) -> AnyPublisher<DataResponse<SharedProfileModel, NetworkError>, Never>
    
    
    func fetchProfileImageGallery( token: String ) -> AnyPublisher<DataResponse< ProfileGalleryResponse, NetworkError>, Never>
    func addProfileImageToGallery( token: String, image: Data ) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never>
    func deleteProfileImageFromGallery( token: String, imageID: Int ) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never>
    func makeProfileImage( token: String, imageID: Int ) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never>

}

class ProfileService {
    static let shared: ProfileServiceProtocol = ProfileService()
    
    private init() { }
}

extension ProfileService: ProfileServiceProtocol {
    
    func fetchSharedProfile(userID: Int) -> AnyPublisher<DataResponse<SharedProfileModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/sharedUser/\(userID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: SharedProfileModel.self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func flagUser(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/flag")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    
    func reportUser(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/report")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    
    func blockUser(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/block")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    
    func fetchProfileWithPusher(channel: PusherChannel, completion: @escaping (UserModel) -> ()) {
        
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
    func withdrawFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/withdrawFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    
    func fetchPendingRequests(token: String, page: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/pendingRequests/\(page)")!
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
    func fetchFriendRequests(token: String, page: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/myRequests/\(page)")!
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
    
    func acceptFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/acceptFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    
    func rejectFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/rejectFriendRequest")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : userID],
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
    // friend requests end
    
    // friends
    func fetchFriends(token: String, page: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/myFriends/\(page)")!
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
    
    func makeProfileImage(token: String, imageID: Int) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/setAvatar")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : imageID],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: ProfileGalleryResponse.self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func addProfileImageToGallery(token: String, image: Data) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/addProfileImage")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
                                    "Content-type": "multipart/form-data"]
        
        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            multipartFormData.append(image, withName: "image", fileName: "\(UUID().uuidString).jpeg" ,mimeType: "image/jpeg")
        }, to: url,
        method: .post,
        headers: headers)
        .validate()
        .publishDecodable(type: ProfileGalleryResponse.self)
        .map { response in
            
            response.mapError { error in
                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                return NetworkError(initialError: error, backendError: backendError)
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func deleteProfileImageFromGallery(token: String, imageID: Int) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/deleteProfileImage")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["id" : imageID],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: ProfileGalleryResponse.self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchProfileImageGallery(token: String) -> AnyPublisher<DataResponse<ProfileGalleryResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/profileImages")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: ProfileGalleryResponse.self)
            .map { response in
                
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
//    func deleteProfileImage(token: String) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never> {
//        let url = URL(string: "\(Credentials.BASE_URL)user/removeAvatar")!
//        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
//
//        return AF.request(url,
//                          method: .delete,
//                          headers: headers)
//            .validate()
//            .publishDecodable(type: UserModel.self)
//            .map { response in
//
//                response.mapError { error in
//                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
//                    return NetworkError(initialError: error, backendError: backendError)
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
//
//    func updateProfileImage(token: String, image: Data ) -> AnyPublisher<DataResponse<UserModel, NetworkError>, Never> {
//        let url = URL(string: "\(Credentials.BASE_URL)user/addAvatar")!
//        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)",
//                                    "Content-type": "multipart/form-data"]
//
//
//        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
//            multipartFormData.append(image, withName: "image", fileName: "\(UUID().uuidString).jpeg" ,mimeType: "image/jpeg")
//        }, to: url,
//        method: .post,
//        headers: headers)
//        .validate()
//        .publishDecodable(type: UserModel.self)
//        .map { response in
//
//            response.mapError { error in
//                let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
//                return NetworkError(initialError: error, backendError: backendError)
//            }
//        }
//        .receive(on: DispatchQueue.main)
//        .eraseToAnyPublisher()
//    }
}
