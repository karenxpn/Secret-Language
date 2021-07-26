//
//  SettingsViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import Foundation
import Combine
import SwiftUI

class SettingsViewModel: ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    
    @Published var gender: String = "Male"
    @Published var fullName: String = "Karen Mirakyan"
    @Published var location: String = "Yerevan, Armenia"
    @Published var birthday: String = "26 Jul, 1999"
}
