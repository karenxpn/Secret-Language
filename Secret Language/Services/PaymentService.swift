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
    func fetchReceiptData(completion: @escaping (String) -> ())
    func postReceiptDataToServer( token: String, receipt: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class PaymentService {
    static let shared: PaymentServiceProtocol = PaymentService()
    
    private init() { }
}

extension PaymentService: PaymentServiceProtocol {
    func postReceiptDataToServer(token: String, receipt: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        
        let url = URL(string: "\(Credentials.BASE_URL)payment/verifyReceipt")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["receipt" : receipt],
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
    
    func fetchReceiptData(completion: @escaping (String) -> ()) {
        if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
            FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

            do {
                let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                let receiptString = receiptData.base64EncodedString(options: [])

                // Read receiptData
                DispatchQueue.main.async {
                    completion( receiptString )
                }
            }
            catch { print("Couldn't read receipt data with error: " + error.localizedDescription) }
        }
    }
    
    func postPaymentStatus(token: String,  reportDate: String, firstReportDate: String, secondReportDate: String, birthdayOrRelationship: Bool ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        
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
