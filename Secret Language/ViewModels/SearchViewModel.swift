//
//  SearchViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @Published var search: String = ""
    @Published var searchResults = [UserPreviewModel(id: 1, name: "Adhraaa Al Azimi", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"), UserPreviewModel(id: 2, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"), UserPreviewModel(id: 3, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business")]
    @Published var ideal: Int = 0
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SearchServiceProtocol
    
    init(dataManager: SearchServiceProtocol = SearchService.shared) {
        self.dataManager = dataManager
        
        $search
            .removeDuplicates()
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .sink { (text) in
                if text != "" {
                    self.getSearchUsers(search: text)
                }
                else {
                    self.getPopularUsers()
                }
            }.store(in: &cancellableSet)
    }
    
    func getSearchUsers(search: String) {
        loading = true
        dataManager.fetchSearchedUsers(token: token, searchText: search, idealFor: ideal)
            .sink { response in
                self.loading = false
                if response.error == nil {
                    self.searchResults = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getPopularUsers() {
        loading = true
        dataManager.fetchPopularUsers(token: token)
            .sink { response in
                self.loading = false
                if response.error == nil {
                    self.searchResults = response.value!
                }
            }.store(in: &cancellableSet)
    }
}
