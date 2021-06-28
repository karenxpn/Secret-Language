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
}
