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
    func fetchBirthdayReport( token: String, date: String ) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never>
    func fetchRelationshipReport( token: String, firstDate: String, secondDate: String ) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never>
}

class ReportService {
    static let shared = ReportService()
    
    private init() { }
}

extension ReportService: ReportServiceProtocol {
    func fetchRelationshipReport(token: String, firstDate: String, secondDate: String) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/showRelationshipReport")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["birthday_1" : firstDate,
                                       "birthday_2" : secondDate],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: RelationshipReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchBirthdayReport(token: String, date: String) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/showBirthdayReport")!
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url,
                          method: .post,
                          parameters: ["birthday" : date],
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
            .validate()
            .publishDecodable(type: BirthdayReportModel.self)
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
