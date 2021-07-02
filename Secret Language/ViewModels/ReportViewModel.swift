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
    
    @Published var birthdayMonth: String = "January"
    @Published var firstReportMonth: String = "January"
    @Published var secondReportMonth: String = "January"

    @Published var birthday: Int = 1
    @Published var firstReportDay: Int = 1
    @Published var secondReportDay: Int = 2
    
    @Published var navigateToReport: Bool = false
    @Published var navigateToPayment: Bool = false
    
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ReportServiceProtocol
    
    init(dataManager: ReportServiceProtocol = ReportService.shared) {
        self.dataManager = dataManager
    }
    
    func checkBirthdayReport() {
        dataManager.checkReportStatusForBirthday(token: token, date: "\(birthdayMonth) \(birthday)")
            .sink { response in
                if response.error == nil {
                    if response.value!.message == "paid" {
                        self.navigateToReport.toggle()
                    } else {
                        self.navigateToPayment.toggle()
                    }                } else {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                }
            }.store(in: &cancellableSet)
    }
    
    func checkRelationshipReport() {
        dataManager.checkReportStatusForRelationship(token: token, firstDate: "\(firstReportMonth) \(firstReportDay)", secondDate: "\(secondReportMonth) \(secondReportDay)")
            .sink { response in
                if response.error == nil {
                    if response.value!.message == "paid" {
                        self.navigateToReport.toggle()
                    } else {
                        self.navigateToPayment.toggle()
                    }
                } else {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                }
            }.store(in: &cancellableSet)
    }
    
    func getBirthdayReport() {
        dataManager.fetchBirthdayReport(token: token, date: "\(birthdayMonth) \(birthday)")
            .sink { response in
                // smth here
            }.store(in: &cancellableSet)
    }
    
    func getRelationshipReport() {
        dataManager.fetchRelationshipReport(token: token, firstDate: "\(firstReportMonth) \(firstReportDay)", secondDate: "\(secondReportMonth) \(secondReportDay)")
            .sink { response in
                // smth here
            }.store(in: &cancellableSet)
    }
    
    func makeAlert( showAlert: inout Bool, message: inout String, error: NetworkError ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        showAlert.toggle()
    }
}
