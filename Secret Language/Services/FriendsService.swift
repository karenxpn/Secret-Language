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

protocol FriendsServiceProtocol {
    func fetchFriendRequests( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func acceptFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    func rejectFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    
    func fetchFriends( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchFriendsAndRequestsCount( token: String ) -> AnyPublisher<DataResponse<FriendsAndRequestsModel, NetworkError>, Never>
    func withdrawFriendRequest( token: String, userID: Int ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchPendingRequests( token: String ) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never>
    
    func fetchContacts(completion: @escaping ( [ContactModel] ) -> ())
}

class FriendsService {
    static let shared = FriendsService()
    
    private init() { }
}

extension FriendsService: FriendsServiceProtocol {
    func withdrawFriendRequest(token: String, userID: Int) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/withdrawRequest")!
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
    
    func fetchContacts(completion: @escaping ([ContactModel]) -> ()) {
        let keyToFetch = [
            CNContactIdentifierKey,
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
            CNContactImageDataKey
        ] as [CNKeyDescriptor]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keyToFetch)
        
        do {
            let store = CNContactStore()
            var contactList: [ContactModel] = []
            
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contactInfo, _ in
                let id = contactInfo.identifier
                let firstName = contactInfo.givenName
                let lastName = contactInfo.familyName
                let phone = contactInfo.phoneNumbers.first!.value.stringValue
                let image = contactInfo.imageData
                contactList.append(ContactModel(id: id, firstName: firstName, lastName: lastName, phone: phone, image: image))
            })
            
            DispatchQueue.main.async {
                completion( contactList )
            }
            
        } catch {
            fatalError(error.localizedDescription)
        }
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
    
    func fetchFriendsAndRequestsCount(token: String) -> AnyPublisher<DataResponse<FriendsAndRequestsModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/friendsRequestsCounts")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: FriendsAndRequestsModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchFriendRequests(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/friendRequests")!
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
    
    func fetchFriends(token: String) -> AnyPublisher<DataResponse<[UserPreviewModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/friends")!
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
}
