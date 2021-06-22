//
//  MatchesViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.06.21.
//

import Foundation
import Combine
import SwiftUI

class MatchesViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @Published var matches = [MatchViewModel]()
    
    @Published var loadingMatches: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var loadingFilter: Bool = false
    
    @Published var dataFilterGenders = [GenderModel(id: 1, gender_name: "Male"),
                                        GenderModel(id: 2, gender_name: "Female"),
                                        GenderModel(id: 0, gender_name: "Everyone")]
    
    @Published var dataFilterCategories = [ConnectionTypeModel]()
    @Published var dataFilterGender: Int = 0
    @Published var dataFilterCategory: Int = 0
    @Published var selectedCategories = [String]()
    @Published var categoryItems = [CategoryItemModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: MatchServiceProtocol
    
    init( dataManager: MatchServiceProtocol = MatchService.shared) {
        self.dataManager = dataManager
    }
    
    func getMatches() {
        loadingMatches = true
        dataManager.fetchMatches(token: token, params: GetMatchesRequest(gender: dataFilterGender, interestedIn: dataFilterCategory, idealFor: selectedCategories))
            .sink { response in
                self.loadingMatches = false
                if response.error != nil {
                    self.alertMessage = response.error!.backendError == nil ? response.error!.initialError.localizedDescription : response.error!.backendError!.message
                    self.showAlert.toggle()
                } else {
                    self.matches = response.value!.map{ MatchViewModel(match: $0 )}
                }
            }.store(in: &cancellableSet)
    }
    
    func getFilterCategoriesWithItems() {
        loadingFilter = true
        Publishers.Zip(dataManager.fetchCategories(token: token), dataManager.fetchAllCategoryItems(token: token))
            .sink { category, categoryItems in
                self.loadingFilter = false
                
                if category.error == nil {
                    self.dataFilterCategories = [ConnectionTypeModel(id: 0, name: "All", description: "")] + category.value!
                }
                if categoryItems.error == nil {
                    self.categoryItems = categoryItems.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func sendLocation(location: Location) {
        dataManager.sendLocation(token: token, location: location)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func removeMatch( matchID: Int ) {
        print(matchID)
        dataManager.removeFromMatches(token: token, matchID:  matchID)
            .sink { response in
                print(matchID)
                print(response)
            }.store(in: &cancellableSet)
    }
    
    func sendFriendRequest( matchID: Int ) {
        dataManager.sendFriendRequest(token: token, matchID: matchID)
            .sink { response in
                print(response)
            }.store(in: &cancellableSet)
    }
}