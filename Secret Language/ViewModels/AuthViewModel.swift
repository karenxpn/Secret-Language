//
//  AuthViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import Foundation
class AuthViewModel: ObservableObject {
    @Published var birthdayDate: Date = Date()
    @Published var signUpPhoneNumber: String = ""
    @Published var signInPhoneNumber: String = ""
}
