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
    @AppStorage("token") private var token: String = ""
    @AppStorage("username") private var username: String = ""
    @AppStorage( "userID" ) private var userID: Int = 0
    @AppStorage( "genderPreference" ) private var locallyStoredGenderPreference: Int = 0
    @AppStorage( "interestedInCategory" ) private var locallyStoredInterestedIn: Int = 0

    
    @Published var gender: GenderModel = GenderModel(id: 1, gender_name: "Male")
    @Published var fullName: String = ""
    @Published var location: String = ""
    @Published var birthday: String = "Jul 26, 1999"
    @Published var instagramUsername: String = ""
    @Published var genderPreference: Int = 0
    @Published var interestedIn: Int = 0
    
    @Published var genderPreferenceText: String = ""
    
    @Published var loading: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var updateAlert: Bool = false
    @Published var updateAlertMessage: String = ""
    
    @Published var allGenders = [GenderModel]()
    @Published var loadingGenders: Bool = false
    
    @Published var allInterests = [ConnectionTypeModel]()
    @Published var loadingInterests: Bool = false
    @Published var interestedInText: String = ""
    
    @Published var locationText: String = ""
    @Published var locationsPage: Int = 1
    @Published var locations = [LocationListItemModel]()
    @Published var loadingLocations: Bool = false
    
    @Published var navigateToGenders: Bool = false
    @Published var navigateToBirthdayPicker: Bool = false
    @Published var navigateToGenderPreferencePicker: Bool = false
    @Published var navigateToInterests: Bool = false
    @Published var navigateToLocation: Bool = false
        
    @Published var birthdayDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date()
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "us")
        formatter.setLocalizedDateFormatFromTemplate("MMMM dd, yyyy")
        return formatter
    }
    
    var stringToDateFormatter: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.date(from: self.birthday)!
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: SettingsServiceProtocol
    var profileDataManager: ProfileServiceProtocol
    var authDataManager: AuthServiceProtocol
    var matchDataManager: MatchServiceProtocol
    
    init( dataManager: SettingsServiceProtocol = SettingsService.shared,
          authDataManager: AuthServiceProtocol = AuthService.shared,
          profileDataManager: ProfileServiceProtocol = ProfileService.shared,
          matchDataManager: MatchServiceProtocol = MatchService.shared) {
        self.dataManager = dataManager
        self.authDataManager = authDataManager
        self.profileDataManager = profileDataManager
        self.matchDataManager = matchDataManager
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
                    self.fullName = settings.name
                    self.location = settings.country_name
                    self.birthday = settings.date_name
                    self.instagramUsername = settings.instagram
                    self.genderPreference = settings.gender_preference
                    self.interestedIn = settings.interested_in.id

                    self.locallyStoredGenderPreference = settings.gender_preference
                    self.locallyStoredInterestedIn = settings.interested_in.id
                    self.interestedInText = settings.interested_in.name
                    
                    switch settings.gender_preference {
                    case 0:
                        self.genderPreferenceText = "Everyone"
                    case 1:
                        self.genderPreferenceText = "Male"
                    case 2:
                        self.genderPreferenceText = "Female"
                    default:
                        break
                    }
                    
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
    
    func getAllInterests() {
        loadingInterests = true
        matchDataManager.fetchCategories(token: token)
            .sink { response in
                self.loadingInterests = false
                if response.error == nil {
                    self.allInterests = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getAllLocations() {
        loadingLocations = true
        dataManager.fetchAllLocations(token: token)
            .sink { response in
                self.loadingLocations = false
                if response.error != nil {
                    self.locations = response.value!
                    self.locationsPage += 1
                }
            }.store(in: &cancellableSet)
    }
    
    func updateFields(updatedFrom: String) {        
        let parameters = SettingsFieldsUpdateModel(date_name: dateFormatter.string(from: self.birthdayDate), name: fullName, gender: gender.id, country_name: location, instagram: instagramUsername, gender_preference: genderPreference, interested_in: interestedIn)
        
        dataManager.updateFields(token: token, parameters: parameters)
            .sink { response in
                
                if response.error == nil {
                    if updatedFrom == "gender" {
                        self.navigateToGenders.toggle()
                    } else if updatedFrom == "birthday" {
                        self.navigateToBirthdayPicker.toggle()
                    } else if updatedFrom == "preferences" {
                        self.navigateToGenderPreferencePicker.toggle()
                    } else if updatedFrom == "interestedIn" {
                        self.navigateToInterests.toggle()
                    }
                    
                    self.getSettingsFields()
                } else {
                    self.makeAlert(with: response.error!, showAlert: &self.updateAlert, alertMessage: &self.updateAlertMessage)
                }
                
            }.store(in: &cancellableSet)
    }
    
    func logout() {
        authDataManager.logout(token: token)
            .sink { response in
                if response.error != nil {
                    self.makeAlert(with: response.error!,
                                   showAlert: &self.showAlert,
                                   alertMessage: &self.alertMessage)
                } else {
                    self.token = ""
                    self.username = ""
                    self.userID = 0
                }
            }.store(in: &cancellableSet)
    }
    
    func deactivateAccount() {
        profileDataManager.deactivateAccount(token: token)
            .sink { response in
                if response.error != nil {
                    self.makeAlert(with: response.error!,
                                   showAlert: &self.showAlert,
                                   alertMessage: &self.alertMessage)
                } else {
                    self.token = ""
                    self.username = ""
                    self.userID = 0
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
