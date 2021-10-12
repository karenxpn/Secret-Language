//
//  ReportViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.06.21.
//

import Foundation
import SwiftUI
import Combine

class ReportViewModel: AlertViewModel, ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "shouldPurchaseReport" ) private var shouldPurchase: Bool = false
    
    @Published var birthdayMonth: String = "January"
    @Published var firstReportMonth: String = "January"
    @Published var secondReportMonth: String = "January"
    
    @Published var birthday: Int = 1
    @Published var firstReportDay: Int = 1
    @Published var secondReportDay: Int = 2
    
    @Published var birthdayYear: Int? = nil
    @Published var firstReportYear: Int? = nil
    @Published var secondReportYear: Int? = nil
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var navigate: Bool = false
    
    @Published var relationshipReport: RelationshipReportModel? = nil
    @Published var birthdayReport: BirthdayReportModel? = nil

    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ReportServiceProtocol
    
    init(dataManager: ReportServiceProtocol = ReportService.shared) {
        self.dataManager = dataManager
    }
    
    func getBirthdayReport() {
        dataManager.fetchBirthdayReport(token: token, date: returnDate(month: birthdayMonth, day: birthday, year: birthdayYear))
            .sink { response in
                if response.error != nil {
                    if response.error!.initialError.responseCode == Credentials.paymentErrorCode {
                        self.shouldPurchase = true
                        self.navigate = true
                    } else {
                        self.makeAlert(with: response.error!,
                                       message: &self.alertMessage,
                                       alert: &self.showAlert)
                    }
                } else {
                    self.birthdayReport = response.value!
                    self.shouldPurchase = false
                    self.navigate = true
                }
            }.store(in: &cancellableSet)
    }
    
    func getRelationshipReport() {
        dataManager.fetchRelationshipReport(token: token,
                                            firstDate: returnDate(month: firstReportMonth, day: firstReportDay, year: firstReportYear),
                                            secondDate: returnDate(month: secondReportMonth, day: secondReportDay, year: secondReportYear))
            .sink { response in
                if response.error != nil {
                    if response.error!.initialError.responseCode == Credentials.paymentErrorCode {
                        self.shouldPurchase = true
                        self.navigate = true
                    } else {
                        self.makeAlert(with: response.error!,
                                       message: &self.alertMessage,
                                       alert: &self.showAlert)
                    }
                } else {
                    self.relationshipReport = response.value!
                    self.shouldPurchase = false
                    self.navigate = true
                }
            }.store(in: &cancellableSet)
    }
    
    func returnDate(month: String, day: Int, year: Int?) -> String {
        return "\(month) \(day)\(year != nil ? ", \(year!)" : "")"
    }
}
