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

    var fetchChatListError: Bool = false
    let chatList = PreviewParameters.chatList
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    
    func fetchChatList(token: String) -> AnyPublisher<DataResponse<[ChatModel], NetworkError>, Never> {
        var result: Result<[ChatModel], NetworkError>
        
        if fetchChatListError   { result = Result<[ChatModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[ChatModel], NetworkError>.success(chatList)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[ChatModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchChatListWithPusher(channel: PusherChannel, completion: @escaping ([ChatModel]) -> ()) { }
}
