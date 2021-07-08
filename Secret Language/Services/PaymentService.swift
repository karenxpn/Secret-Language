//
//  PaymentService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 09.07.21.
//

import Foundation
import Combine
import Alamofire

protocol PaymentServiceProtocol {
    func postPaymentStatus(token: String, reportDate: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class PaymentService {
    static let shared = PaymentService()
    
    private init() { }
}

extension PaymentService: PaymentServiceProtocol {
    func postPaymentStatus(token: String,  reportDate: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        
        print(reportDate)
        let url = URL(string: "\(Credentials.BASE_URL)user/payment")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["reportDate" : reportDate],
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
}
