//
//  ReportService.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import Foundation
import Alamofire
import Combine

protocol ReportServiceProtocol {
    func checkReportStatusForBirthday( token: String, date: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
    func checkReportStatusForRelationship( token: String, firstDate: String, secondDate: String ) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never>
}

class ReportService {
    static let shared = ReportService()
    
    private init() { }
}

extension ReportService: ReportServiceProtocol {
    func checkReportStatusForBirthday(token: String, date: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/checkBirthday")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["date" : date],
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
    
    func checkReportStatusForRelationship(token: String, firstDate: String, secondDate: String) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/checkRelationship")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["first" : firstDate,
                                       "second" : secondDate],
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
