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
    
    // shared reports
    func fetchSharedBirthdayReport( reportID: Int ) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never>
    
    func fetchSharedRelationshipReport( reportID: Int ) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never>
    
    func fetchSharedDayReport( reportID: Int ) -> AnyPublisher<DataResponse<DayReportModel, NetworkError>, Never>
    func fetchSharedWeekReport( reportID: Int ) -> AnyPublisher<DataResponse<WeekReportModel, NetworkError>, Never>
    func fetchSharedMonthReport( reportID: Int ) -> AnyPublisher<DataResponse<MonthReportModel, NetworkError>, Never>
    func fetchSharedSeasonReport( reportID: Int ) -> AnyPublisher<DataResponse<SeasonReportModel, NetworkError>, Never>
    func fetchSharedWayReport( reportID: Int ) -> AnyPublisher<DataResponse<WayReportModel, NetworkError>, Never>
    func fetchSharedPathReport( reportID: Int ) -> AnyPublisher<DataResponse<PathReportModel, NetworkError>, Never>
}

class ReportService {
    static let shared: ReportServiceProtocol = ReportService()
    
    private init() { }
}

extension ReportService: ReportServiceProtocol {
    func fetchSharedDayReport(reportID: Int) -> AnyPublisher<DataResponse<DayReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getDayReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: DayReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSharedWeekReport(reportID: Int) -> AnyPublisher<DataResponse<WeekReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getWeekReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: WeekReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSharedMonthReport(reportID: Int) -> AnyPublisher<DataResponse<MonthReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getMonthReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: MonthReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSharedSeasonReport(reportID: Int) -> AnyPublisher<DataResponse<SeasonReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getSeasonReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: SeasonReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSharedWayReport(reportID: Int) -> AnyPublisher<DataResponse<WayReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getWayReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: WayReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSharedPathReport(reportID: Int) -> AnyPublisher<DataResponse<PathReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getPathReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: PathReportModel.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func fetchSharedBirthdayReport(reportID: Int) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getBirthdayReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
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
    
    func fetchSharedRelationshipReport(reportID: Int) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never> {
        let url = URL(string: "\(Credentials.BASE_URL)user/getRelationshipReport/\(reportID)")!
        
        return AF.request(url,
                          method: .get)
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
        let url = URL(string: "\(Credentials.BASE_URL)user/showBirthdayReportWithYear")!
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
