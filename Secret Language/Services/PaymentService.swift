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
    func postPaymentStatus(token: String, reportDate: String, firstReportDate: String, secondReportDate: String, birthdayOrRelationship: Bool ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class PaymentService {
    static let shared: PaymentServiceProtocol = PaymentService()
    
    private init() { }
}

extension PaymentService: PaymentServiceProtocol {
    func postPaymentStatus(token: String,  reportDate: String, firstReportDate: String, secondReportDate: String, birthdayOrRelationship: Bool ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        
        
        if birthdayOrRelationship {
            print("posting relationship with parameters" )
            print("\(firstReportDate) \(secondReportDate)")
        } else {
            print("posting birthday report with parameters")
            print(reportDate)
        }
        
        let url = URL(string: "\(Credentials.BASE_URL)user/addPaidReport")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: birthdayOrRelationship ? ["birthday_1" : firstReportDate,
                                                                "birthday_2" : secondReportDate] :
                                                               ["birthday" : reportDate],
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
