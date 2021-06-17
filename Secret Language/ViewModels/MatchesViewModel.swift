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
    
    @Published var dataFilterGenders = ["Male", "Female", "Everyone"]
    @Published var dataFilterCategories = [ConnectionTypeModel]()
    @Published var dataFilterGender: String = ""
    @Published var dataFilterCategory: String = NSLocalizedString("all", comment: "")
    @Published var selectedCategories = [String]()
    @Published var categoryItems = [CategoryItemModel]()
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: MatchServiceProtocol
    
    init( dataManager: MatchServiceProtocol = MatchService.shared) {
        self.dataManager = dataManager
    }
    
    func getMatches() {
        loadingMatches = true
        dataManager.fetchMatches(token: token)
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
}
