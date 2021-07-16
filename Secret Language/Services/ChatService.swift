//
//  ChatService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.07.21.
//

import Foundation
import Combine
import Alamofire
import PusherSwift

protocol ChatServiceProtocol {
    func fetchChatList( token: String ) -> AnyPublisher<DataResponse<[ChatModel], NetworkError>, Never>
    func fetchChatListWithPusher( channel: PusherChannel, completion: @escaping ( [ChatModel] ) -> () )
    func fetchRoomMessages(token: String, roomID: Int, lastMessageID: Int) -> AnyPublisher<DataResponse<[Message], NetworkError>, Never>
}

class ChatService {
    static let shared: ChatServiceProtocol = ChatService()
    
    private init() { }
}

extension ChatService: ChatServiceProtocol {
    func fetchChatList(token: String) -> AnyPublisher<DataResponse<[ChatModel], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)chats")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: [ChatModel].self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchChatListWithPusher(channel: PusherChannel, completion: @escaping ([ChatModel]) -> ()) {
        channel.bind(eventName: "chats", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    guard let chats = try? JSONDecoder().decode([ChatModel].self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(chats)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
    func fetchRoomMessages(token: String, roomID: Int, lastMessageID: Int) -> AnyPublisher<DataResponse<[Message], NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)chats/\(roomID)/messages/\(lastMessageID)")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .get,
                          headers: headers)
            .validate()
            .publishDecodable(type: [Message].self)
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
