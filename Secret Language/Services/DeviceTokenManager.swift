//
//  DeviceTokenManager.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.07.21.
//

import Combine
import Alamofire

class DeviceTokenManager {
    private init() { }
    static let shared = DeviceTokenManager()
        
    func sendDeviceToken( token: String, deviceToken: String ) -> AnyPublisher<GlobalResponse, Error> {
        let url = URL(string: "\(Credentials.BASE_URL)get-device-token")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["device_token" : deviceToken],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: GlobalResponse.self)
            .value()
            .mapError{ $0 as Error }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
