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
    
    @AppStorage("token") private var token: String = ""
    
    @Published var birthdayDate: Date = Date()
    @Published var signUpPhoneNumber: String = ""
    @Published var singUpVerificationCode: String = ""
    @Published var signUpGender: String = ""
    
    @Published var genderFilter: String = ""
    @Published var moreGenders = [GenderModel]()
    
    @Published var signInPhoneNumber: String = ""
    @Published var signInVerificationCode: String = ""
    
    @Published var navigateToSignInVerificationCode: Bool = false
        
    // alerts
    @Published var showAlert: Bool = false
    @Published var sendVerificationCodeAlertMessage: String = ""
    
    @Published var showCheckVerificationCodeAlert: Bool = false
    @Published var checkVerificationCodeAlertMessage: String = ""
        
    @Published var navigateToCheckVerificationCode: Bool = false
    @Published var navigateToChooseGender: Bool = false
    
    // check publishers validation
    @Published var isSendVerificationCodeClickable: Bool = false
    @Published var isCheckVerificationCodeClickable: Bool = false
    @Published var isSignInProceedClickable: Bool = false
    
    @Published var loadingGenders: Bool = false
    @Published var connectionType: String = ""
    
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
        dataManager.sendVerificationCode(phoneNumber: signUpPhoneNumber, birthday: dateFormatter.string(from: birthdayDate))
            .sink { response in
                if response.error != nil {
                    self.sendVerificationCodeAlertMessage = response.error!.backendError == nil ? response.error!.initialError.localizedDescription : response.error!.backendError!.message.first ?? "Please try again later"
                    self.showAlert.toggle()
                } else {
                    self.navigateToCheckVerificationCode.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func checkVerificationCode() {
        dataManager.checkVerificationCode(phoneNumber: signUpPhoneNumber, code: singUpVerificationCode)
            .sink { response in
                if response.error != nil {
                    self.checkVerificationCodeAlertMessage = response.error!.backendError == nil ? response.error!.initialError.localizedDescription : response.error!.backendError!.message.first ?? "Please try again later"
                    self.showCheckVerificationCodeAlert.toggle()
                } else {
                    self.navigateToChooseGender.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func sendSignInVerificationCode() {
        
        dataManager.sendSignInVerificationCode(phoneNumber: signInPhoneNumber)
            .sink { response in
                if response.error != nil {
                    self.sendVerificationCodeAlertMessage = response.error!.backendError == nil ? response.error!.initialError.localizedDescription : response.error!.backendError!.message.first ?? "Please try again later"
                    self.showAlert.toggle()
                } else {
                    self.navigateToSignInVerificationCode.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func checkSignInVerificationCode() {
        dataManager.checkSignInVerificationCode(phoneNumber: signInPhoneNumber, code: signInVerificationCode)
            .sink { response in
                if response.error != nil {
                    self.checkVerificationCodeAlertMessage = response.error!.backendError == nil ? response.error!.initialError.localizedDescription : response.error!.backendError!.message.first ?? "Please try again later"
                    self.showCheckVerificationCodeAlert.toggle()
                } else {
                    // do smth
                }
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
}
