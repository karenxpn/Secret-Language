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
    
    @Published var loading: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var showUpdateAlert: Bool = false
    @Published var updateAlertMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SettingsServiceProtocol
    
    init( dataManager: SettingsServiceProtocol = SettingsService.shared) {
        self.dataManager = dataManager
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
                    self.birthday = settings.age
                }
            }.store(in: &cancellableSet)
    }
    
    func updateFields() {
        let parameters = SettingsFields(gender: gender, age: birthday, location: location, fullName: fullName)
        
        dataManager.updateFields(token: token, parameters: parameters)
            .sink { response in
                if response.error != nil {
                    self.makeAlert(with: response.error!,
                                   showAlert: &self.showUpdateAlert,
                                   alertMessage: &self.updateAlertMessage)
                } else {
                    self.makeSuccessAlert(with: response.value!,
                                          showAlert: &self.showUpdateAlert,
                                          alertMessage: &self.updateAlertMessage)
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
