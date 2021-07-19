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
    func fetchMessagesListWithPusher( channel: PusherChannel, roomID: Int, completion: @escaping ( Message ) -> () )
    
    func sendMessage( token: String, roomID: Int, message: SendingMessageModel) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func sendTypingStatus( token: String, roomID: Int, typing: Bool ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func getTypingStatus( channel: PusherChannel, token: String, roomID: Int, completion: @escaping ( Bool ) -> () )
}

class ChatService {
    static let shared: ChatServiceProtocol = ChatService()
    
    private init() { }
}

extension ChatService: ChatServiceProtocol {
    func getTypingStatus(channel: PusherChannel, token: String, roomID: Int, completion: @escaping (Bool) -> ()) {
        channel.bind(eventName: "chatMessages\(roomID)", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    print(data)
                    guard let typing = try? JSONDecoder().decode(TypingResponse.self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(typing.typing)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
    func sendTypingStatus(token: String, roomID: Int, typing: Bool) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)sendTyping\(roomID)")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["typing" : typing],
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
    
    func sendMessage(token: String, roomID: Int, message: SendingMessageModel) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)sendMessage\(roomID)")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: message,
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
    
    func fetchMessagesListWithPusher(channel: PusherChannel, roomID: Int, completion: @escaping (Message) -> ()) {
        channel.bind(eventName: "chatMessages\(roomID)", eventCallback: { (event: PusherEvent) -> Void in
            if let stringData: String = event.data {
                if let data = stringData.data(using: .utf8) {
                    
                    guard let message = try? JSONDecoder().decode(Message.self, from: data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        completion(message)
                    }
                    
                } else {
                    return
                }
            }
        })
    }
    
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
