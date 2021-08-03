//
//  MockChatService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 15.07.21.
//

import Foundation
import Combine
import Alamofire
import PusherSwift
@testable import Secret_Language

class MockChatService: ChatServiceProtocol {
    
    var deleteChatError: Bool = false
    
    func deleteChat(token: String, roomID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if deleteChatError  { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchRoomMessages(token: String, roomID: Int, lastMessageID: Int) -> AnyPublisher<DataResponse<[Message], NetworkError>, Never> {
        var result: Result<[Message], NetworkError>
        
        if fetchRoomMessagesError   { result = Result<[Message], NetworkError>.failure(networkError)}
        else                        { result = Result<[Message], NetworkError>.success(messages)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[Message], NetworkError>, Never>( response )
        return publisher.eraseToAnyPublisher()
    }
    
    func sendMessage(token: String, roomID: Int, message: SendingMessageModel) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let result = Result<GlobalResponse, NetworkError>.success(globalResponse)
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func sendGreetingMessage(token: String, userID: Int, message: SendingMessageModel) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        var result: Result<GlobalResponse, NetworkError>
        
        if sendGreetingMessageError { result = Result<GlobalResponse, NetworkError>.failure(networkError)}
        else                        { result = Result<GlobalResponse, NetworkError>.success(globalResponse)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>( response )
        return publisher.eraseToAnyPublisher()
    }
    
    func sendTypingStatus(token: String, roomID: Int, typing: Bool) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let result = Result<GlobalResponse, NetworkError>.success(globalResponse)
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    

    var fetchChatListError: Bool = false
    var fetchRoomMessagesError: Bool = false
    var sendGreetingMessageError: Bool = false
    
    let chatList = PreviewParameters.chatList
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let globalResponse = GlobalResponse(status: "success", message: "message")
    let messages = [Message(id: 1, content: [ContentModel(message: "text", type: "text")], user: MessageUserModel(id: 21, name: "karen", image: ""), created_at: "", read: false)]
    
    func fetchChatList(token: String) -> AnyPublisher<DataResponse<[ChatModel], NetworkError>, Never> {
        var result: Result<[ChatModel], NetworkError>
        
        if fetchChatListError   { result = Result<[ChatModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[ChatModel], NetworkError>.success(chatList)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[ChatModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchChatListWithPusher(channel: PusherChannel, completion: @escaping ([ChatModel]) -> ()) { }
    
    func getTypingStatus(channel: PusherChannel, roomID: Int, completion: @escaping (Bool) -> ()) { }
    
    func fetchMessageWithPusher(channel: PusherChannel, roomID: Int, completion: @escaping (Message) -> ()) { }
}
