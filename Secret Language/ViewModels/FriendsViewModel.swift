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
}
