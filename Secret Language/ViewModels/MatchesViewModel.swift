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
    
    @Published var dataFilterGenders = ["Male", "Female", "Everyone"]
    @Published var dataFilterCategories = ["All", "Romance", "Friendship", "Business"]
    @Published var dataFilterGender: String = ""
    @Published var dataFilterCategory: String = "All"
    @Published var selectedCategories = [String]()
    @Published var categoryItems = ["work", "love", "art", "cool", "sibling", "stay", "family", "night", "sun", "teach", "sleep"]
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: MatchServiceProtocol
    
    init( dataManager: MatchServiceProtocol = MatchService.shared) {
        self.dataManager = dataManager
    }
    
    func getMatches() {
        loadingMatches = true
        dataManager.fetchMatchs(token: token)
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
}
