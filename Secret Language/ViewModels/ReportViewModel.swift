//
//  ReportViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import Foundation
import SwiftUI
import Combine

class ReportViewModel: ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "shouldPurchaseReport" ) private var shouldPurchase: Bool = false
    
    @Published var birthdayMonth: String = "January"
    @Published var firstReportMonth: String = "January"
    @Published var secondReportMonth: String = "January"
    
    @Published var birthday: Int = 1
    @Published var firstReportDay: Int = 1
    @Published var secondReportDay: Int = 2
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    ///
    @Published var navigate: Bool = false
    
    @Published var relationshipReport: RelationshipReportModel? = nil
    @Published var birthdayReport: BirthdayReportModel? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ReportServiceProtocol
    
    init(dataManager: ReportServiceProtocol = ReportService.shared) {
        self.dataManager = dataManager
    }
    
    func getBirthdayReport() {
        dataManager.fetchBirthdayReport(token: token, date: "\(birthdayMonth) \(birthday)")
            .sink { response in
                
                if response.error != nil {
                    if response.error!.initialError.responseCode == 440 {
                        self.shouldPurchase = true
                        self.navigate.toggle()
                    } else {
                        self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                    }
                } else {
                    self.birthdayReport = response.value!
                    self.shouldPurchase = false
                    self.navigate.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func getRelationshipReport() {
        dataManager.fetchRelationshipReport(token: token, firstDate: "\(firstReportMonth) \(firstReportDay)", secondDate: "\(secondReportMonth) \(secondReportDay)")
            .sink { response in
                if response.error != nil {
                    if response.error!.initialError.responseCode == 440 {
                        self.shouldPurchase = true
                        self.navigate.toggle()
                        
                    } else {
                        self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                    }
                } else {
                    self.shouldPurchase = true  // replace with false
                    self.navigate.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func makeAlert( showAlert: inout Bool, message: inout String, error: NetworkError ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        showAlert.toggle()
    }
}
