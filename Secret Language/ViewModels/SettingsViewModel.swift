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
    
    @Published var gender: GenderModel = GenderModel(id: 1, gender_name: "Male")
    @Published var fullName: String = "Karen Mirakyan"
    @Published var location: String = "Yerevan, Armenia"
    @Published var birthday: String = "26 Jul,1999"
    
    @Published var loading: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var updateAlert: Bool = false
    @Published var updateAlertMessage: String = ""
    
    @Published var allGenders = [GenderModel]()
    @Published var loadingGenders: Bool = false
    @Published var navigateToGenders: Bool = false
    @Published var navigateToBirthdayPicker: Bool = false
    
    @Published var birthdayDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var stringToDateFormatter: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM,yyyy"
        return dateFormatter.date(from: self.birthday)!
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SettingsServiceProtocol
    var authDataManager: AuthServiceProtocol
    
    init( dataManager: SettingsServiceProtocol = SettingsService.shared,
          authDataManager: AuthServiceProtocol = AuthService.shared) {
        self.dataManager = dataManager
        self.authDataManager = authDataManager
        
        getSettingsFields()
    }
    
    func getSettingsFields() {
        loading = true
        dataManager.fetchSettingsFields(token: token)
            .sink { response in
                self.loading = false
                
                if response.error != nil {
                    self.makeAlert(with: response.error!,
                                   showAlert: &self.showAlert,
                                   alertMessage: &self.alertMessage)
                } else {
                    let settings = response.value!
                    
                    self.gender = settings.gender
                    self.fullName = settings.fullName
                    self.location = settings.location
                    self.birthday = settings.birthday
                    
                    self.birthdayDate = self.stringToDateFormatter
                }
            }.store(in: &cancellableSet)
    }
    
    func getAllGenders() {
        loadingGenders = true
        authDataManager.fetchAllGenders()
            .sink { response in
                self.loadingGenders = false
                if response.error == nil {
                    self.allGenders = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func updateFields(updatedFrom: String) {
        let parameters = SettingsFields(gender: gender, birthday: dateFormatter.string(from: self.birthdayDate), location: location, fullName: fullName)
        
        dataManager.updateFields(token: token, parameters: parameters)
            .sink { response in
                
                if response.error == nil {
                    if updatedFrom == "gender" {
                        self.navigateToGenders.toggle()
                    } else if updatedFrom == "birthday" {
                        self.navigateToBirthdayPicker.toggle()
                    }
                    
                    self.getSettingsFields()
                } else {
                    self.makeAlert(with: response.error!, showAlert: &self.updateAlert, alertMessage: &self.updateAlertMessage)
                }
                
            }.store(in: &cancellableSet)
    }
    
    func makeAlert( with error: NetworkError, showAlert: inout Bool, alertMessage: inout String ) {
        alertMessage = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        showAlert.toggle()
    }
    
    func makeSuccessAlert( with response: GlobalResponse, showAlert: inout Bool, alertMessage: inout String ) {
        alertMessage = response.message
        showAlert.toggle()
    }
    
}
