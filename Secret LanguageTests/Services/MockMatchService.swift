//
//  MockMatchService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 16.06.21.
//

import Foundation
import Alamofire
import Combine
@testable import Secret_Language

class MockMatchService: MatchServiceProtocol {
    
    func fetchSingleMatch(token: String, userID: Int) -> AnyPublisher<DataResponse<MatchModel, NetworkError>, Never> {
        var result: Result<MatchModel, NetworkError>
        
        if fetchSingleMatchError    { result = Result<MatchModel, NetworkError>.failure(networkError)}
        else                        { result = Result<MatchModel, NetworkError>.success(singleMatch)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<MatchModel, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    

    func sendLocation(token: String, location: Location) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let result: Result<GlobalResponse, NetworkError> = Result<GlobalResponse, NetworkError>.success(globalResponse)
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func removeFromMatches(token: String, matchID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let result: Result<GlobalResponse, NetworkError> = Result<GlobalResponse, NetworkError>.success(globalResponse)
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func sendFriendRequest(token: String, matchID: Int) -> AnyPublisher<DataResponse<GlobalResponse, NetworkError>, Never> {
        let result: Result<GlobalResponse, NetworkError> = Result<GlobalResponse, NetworkError>.success(globalResponse)
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        
        let publisher = CurrentValueSubject<DataResponse<GlobalResponse, NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }

    var fetchMatchesError: Bool = false
    var fetchCategoriesError: Bool = false
    var fetchAllCategoryItemsError: Bool = false
    var fetchSingleMatchError: Bool = false
        
    let matches = [MatchModel(id: 1, username: "username", name: "John Smith", age: 26, sln: "Solved Blissful Wizard", sln_description: "This name describes the life energy of this day. People born during this day will ratain and radiate its energy and will exhibit most of the personality traits we discovered for their day, week, month, season and year as shown below", rel_image: "", report: "This relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.\\r\\nSiblings in this combination will seem as different as night and day, but their personalities can dovetail well. The dangers here are overdependence and a lack of individual development. Differences of temperament in parent-child combinations (Week of Determination people serious and demanding, Cusp of Energy persons fun-loving and flexible) may establish a contentious but rarely boring family dynamic. Since the relationship does well grounding itself in daily activities, career matchups are favored. These two can work side by side for years and still maintain their individuality. They will constitute an effective unit for getting the job done efficiently and dependably.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", ideal_for: "friendship", images: ["https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png"], famous_years: "1702 1758 1814 1851 1907 1944 2000", my_birthday: "December 26, 1993", my_birthday_name: "Ruler", user_birthday: "January 23, 1983", user_birthday_name: "Ruler", distance: "3km away", instagram: "karenmirakyan")]
    let connectionTypes = [ConnectionTypeModel(id: 1, name: "Business", description: "desctiption")]
    let categories = [CategoryItemModel(name: "a")]
    let globalResponse = GlobalResponse(status: "success", message: "message")
    let singleMatch = MatchModel(id: 1, username: "username", name: "John Smith", age: 26, sln: "Solved Blissful Wizard", sln_description: "This name describes the life energy of this day. People born during this day will ratain and radiate its energy and will exhibit most of the personality traits we discovered for their day, week, month, season and year as shown below", rel_image: "", report: "This relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.\\r\\nSiblings in this combination will seem as different as night and day, but their personalities can dovetail well. The dangers here are overdependence and a lack of individual development. Differences of temperament in parent-child combinations (Week of Determination people serious and demanding, Cusp of Energy persons fun-loving and flexible) may establish a contentious but rarely boring family dynamic. Since the relationship does well grounding itself in daily activities, career matchups are favored. These two can work side by side for years and still maintain their individuality. They will constitute an effective unit for getting the job done efficiently and dependably.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", ideal_for: "friendship", images: ["https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png"], famous_years: "1702 1758 1814 1851 1907 1944 2000", my_birthday: "December 26, 1993", my_birthday_name: "Ruler", user_birthday: "January 23, 1983", user_birthday_name: "Ruler", distance: "3km away", instagram: "karenmirakyan")

    
    
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    
    func fetchMatches(token: String, page: Int, params: GetMatchesRequest) -> AnyPublisher<DataResponse<[MatchModel], NetworkError>, Never> {
        var result: Result<[MatchModel], NetworkError>
        
        if fetchMatchesError    { result = Result<[MatchModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[MatchModel], NetworkError>.success(matches)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[MatchModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchCategories(token: String) -> AnyPublisher<DataResponse<[ConnectionTypeModel], NetworkError>, Never> {
        var result: Result<[ConnectionTypeModel], NetworkError>
        
        if fetchCategoriesError { result = Result<[ConnectionTypeModel], NetworkError>.failure(networkError)}
        else                    { result = Result<[ConnectionTypeModel], NetworkError>.success(connectionTypes)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[ConnectionTypeModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchAllCategoryItems(token: String) -> AnyPublisher<DataResponse<[CategoryItemModel], NetworkError>, Never> {
        var result: Result<[CategoryItemModel], NetworkError>
        
        if fetchAllCategoryItemsError   { result = Result<[CategoryItemModel], NetworkError>.failure(networkError)}
        else                            { result = Result<[CategoryItemModel], NetworkError>.success(categories)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<[CategoryItemModel], NetworkError>, Never>(response)
        return publisher.eraseToAnyPublisher()
    }
}
