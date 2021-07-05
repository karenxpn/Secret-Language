//
//  MockReportService.swift
//  Secret LanguageTests
//
//  Created by Karen Mirakyan on 03.07.21.
//

import Foundation
@testable import Secret_Language
import Alamofire
import Combine

class MockReportService: ReportServiceProtocol {
    var fetchBirthdayReportError: Bool = false
    var fetchRelationshipReportError: Bool = false
    
    let networkError = NetworkError(initialError: AFError.explicitlyCancelled, backendError: nil)
    let globalResponse = GlobalResponse(status: "success", message: "paid")
    let birthdayModel = BirthdayReportModel(id: 1, title: "Birthday")
    let relationshipModel = RelationshipReportModel(id: 1, birthday_1: "19 January", birthday_1_name: "Week of Love", birthday_2: "20 January", birthday_2_name: "Week of friendship", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/rel/150/png/0066.png", name: "Creature comforts", s1: "Aesthetic", s2: "Cultiral", s3: "Secure", w1: "Aesthetic", w2: "Cultural", w3: "Secure", ideal_for: "Family", report: "his relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", problematic_for: "Friendship")
    
    func fetchBirthdayReport(token: String, date: String) -> AnyPublisher<DataResponse<BirthdayReportModel, NetworkError>, Never> {
        var result: Result<BirthdayReportModel, NetworkError>
        
        if fetchBirthdayReportError { result = Result<BirthdayReportModel, NetworkError>.failure(networkError)}
        else                        { result = Result<BirthdayReportModel, NetworkError>.success(birthdayModel)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<BirthdayReportModel, NetworkError>, Never>( response)
        return publisher.eraseToAnyPublisher()
    }
    
    func fetchRelationshipReport(token: String, firstDate: String, secondDate: String) -> AnyPublisher<DataResponse<RelationshipReportModel, NetworkError>, Never> {
        var result: Result<RelationshipReportModel, NetworkError>
        
        if fetchRelationshipReportError { result = Result<RelationshipReportModel, NetworkError>.failure(networkError)}
        else                            { result = Result<RelationshipReportModel, NetworkError>.success(relationshipModel)}
        
        let response = DataResponse(request: nil, response: nil, data: nil, metrics: nil, serializationDuration: 0, result: result)
        let publisher = CurrentValueSubject<DataResponse<RelationshipReportModel, NetworkError>, Never>( response )
        return publisher.eraseToAnyPublisher()
    }
}
