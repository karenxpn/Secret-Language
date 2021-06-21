//
//  FriendsViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import Foundation
import Combine
import SwiftUI

class FriendsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var friendsCount: Int = 22
    @Published var pendingCount: Int = 45
    @Published var requestsCount: Int = 3
    
    @Published var friendsList = [UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"), UserPreviewModel(id: 2, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"), UserPreviewModel(id: 3, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"), UserPreviewModel(id: 4, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business")]
    @Published var requestsList = [UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"), UserPreviewModel(id: 2, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"), UserPreviewModel(id: 3, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business"), UserPreviewModel(id: 4, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal_for: "Business")]
}
