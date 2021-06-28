//
//  SearchViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var searchResults = [UserPreviewModel(id: 1, name: "Adhraaa Al Azimi", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"), UserPreviewModel(id: 2, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"), UserPreviewModel(id: 3, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business")]
}
