//
//  AuthViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import Foundation
import Combine
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @AppStorage( "newRelease" ) private var newRelease: Bool = true
    @AppStorage( "initialToken" ) private var initialToken: String = ""
    @AppStorage("token") private var token: String = ""
    @AppStorage("username") private var username: String = ""
    @AppStorage( "userID" ) private var userID: Int = 0
    @AppStorage( "interestedInCategory" ) private var interestedInCategory: Int = 0
    
    @Published var birthdayDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    @Published var signUpCountryCode: String = "United States"
    @Published var signUpPhoneNumber: String = ""
    @Published var singUpVerificationCode: String = ""
    @Published var signUpFullName: String = ""
    @Published var signUpGender: Int? = nil
    
    @Published var agreement: Bool = false
    
    @Published var genderFilter: String = ""
    @Published var moreGenders = [GenderModel]()
    
    @Published var signInCountryCode: String = "United States"
    @Published var signInPhoneNumber: String = ""
    @Published var signInVerificationCode: String = ""
    
    @Published var navigateToSignInVerificationCode: Bool = false
        
    // alerts
    @Published var showAlert: Bool = false
    @Published var sendVerificationCodeAlertMessage: String = ""
    
    @Published var showSignUpAlert: Bool = false
    @Published var signUpAlertMessage: String = ""
    
    @Published var showCheckVerificationCodeAlert: Bool = false
    @Published var checkVerificationCodeAlertMessage: String = ""
        
    @Published var navigateToCheckVerificationCode: Bool = false
    @Published var navigateToFullNamePage: Bool = false
    @Published var navigateToChooseGender: Bool = false
    
    // check publishers validation
    @Published var isSendVerificationCodeClickable: Bool = false
    @Published var isCheckVerificationCodeClickable: Bool = false
    @Published var isSignInProceedClickable: Bool = false
    
    @Published var loadingGenders: Bool = false
    @Published var connectionType: Int? = nil
    
    @Published var loadingConnectionTypes: Bool = false
    @Published var connectionTypes = [ConnectionTypeModel]()

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: AuthServiceProtocol
    
    init( dataManager: AuthServiceProtocol = AuthService.shared) {
        self.dataManager = dataManager
        
        isSignUpPhoneNumberValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isSendVerificationCodeClickable, on: self)
            .store(in: &cancellableSet)
        
        isVerificationCodeValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isCheckVerificationCodeClickable, on: self)
            .store(in: &cancellableSet)
        
        isSignInPhoneNumberValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isSignInProceedClickable, on: self)
            .store(in: &cancellableSet)
    }
    
    func sendVerificationCode() {
        dataManager.sendVerificationCode(phoneNumber: Credentials.countryCodeList[signUpCountryCode]! + signUpPhoneNumber, birthday: dateFormatter.string(from: birthdayDate))
            .sink { response in
                if response.error != nil {
                    self.sendVerificationCodeAlertMessage = self.createErrorMessage(error: response.error!)
                    self.showAlert.toggle()
                } else {
                    self.initialToken = response.value!.token
                    self.navigateToCheckVerificationCode.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func resendSignUpVerificationCode() {
        dataManager.resendVerificationCode(phoneNumber: Credentials.countryCodeList[signUpCountryCode]! + signUpPhoneNumber)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func checkVerificationCode() {
        dataManager.checkVerificationCode(token: initialToken, phoneNumber: Credentials.countryCodeList[signUpCountryCode]! + signUpPhoneNumber, code: singUpVerificationCode)
            .sink { response in
                if response.error != nil {
                    self.checkVerificationCodeAlertMessage = self.createErrorMessage(error: response.error!)
                    self.showCheckVerificationCodeAlert.toggle()
                    
                    self.singUpVerificationCode = ""
                } else {
                    self.navigateToFullNamePage.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func signUp() {
        dataManager.signUp(token: initialToken, fullName: signUpFullName, gender: signUpGender ?? 0, connectionType: connectionType ?? 0)
            .sink { response in
                if response.error != nil {
                    self.signUpAlertMessage = self.createErrorMessage(error: response.error!)
                    self.showSignUpAlert.toggle()
                } else {
                    self.newRelease = false
                    self.token = response.value!.token
                    self.username = response.value!.username
                    self.userID = response.value!.id
                    self.interestedInCategory = response.value!.interestedIn
                    self.initialToken = ""
                }
            }.store(in: &cancellableSet)
    }
    
    func sendSignInVerificationCode() {
        
        dataManager.sendSignInVerificationCode(phoneNumber: Credentials.countryCodeList[signInCountryCode]! + signInPhoneNumber)
            .sink { response in
                if response.error != nil {
                    self.sendVerificationCodeAlertMessage = self.createErrorMessage(error: response.error!)
                    self.showAlert.toggle()
                } else {
                    self.navigateToSignInVerificationCode.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func checkSignInVerificationCode() {
        dataManager.checkSignInVerificationCode(phoneNumber: Credentials.countryCodeList[signInCountryCode]! + signInPhoneNumber, code: signInVerificationCode)
            .sink { response in
                if response.error != nil {
                    self.checkVerificationCodeAlertMessage = self.createErrorMessage(error: response.error!)
                    self.showCheckVerificationCodeAlert.toggle()
                    
                    self.signInVerificationCode = ""
                } else {
                    self.newRelease = false
                    self.token = response.value!.token
                    self.username = response.value!.username
                    self.userID = response.value!.id
                    self.interestedInCategory = response.value!.interestedIn
                }
            }.store(in: &cancellableSet)
    }
    
    func resendSignInVerificationCode() {
        dataManager.resendVerificationCode(phoneNumber: Credentials.countryCodeList[signInCountryCode]! + signInPhoneNumber)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
    
    func getAllGenders() {
        
        loadingGenders = true
        dataManager.fetchAllGenders()
            .sink { response in
                self.loadingGenders = false
                if response.error == nil {
                    self.moreGenders = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getConnectionTypes() {
        loadingConnectionTypes = true
        dataManager.fetchConnectionTypes()
            .sink { response  in
                self.loadingConnectionTypes = false
                if response.error == nil {
                    self.connectionTypes = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    // sign up
    private var isSignUpPhoneNumberValidPublisher: AnyPublisher<Bool, Never> {
        $signUpPhoneNumber
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var isVerificationCodeValidPublisher: AnyPublisher<Bool, Never> {
        $singUpVerificationCode
            .map { $0.count == 6 }
            .eraseToAnyPublisher()
    }
    
    // sign in
    private var isSignInPhoneNumberValidPublisher: AnyPublisher<Bool, Never> {
        $signInPhoneNumber
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    func createErrorMessage( error: NetworkError ) -> String {
        return error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
    }
}
