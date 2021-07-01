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
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ReportServiceProtocol
    
    init(dataManager: ReportServiceProtocol = ReportService.shared) {
        self.dataManager = dataManager
    }
    
    func checkBirthdayReport() {
        dataManager.checkReportStatusForBirthday(token: token, date: "\(birthdayMonth) \(birthday)")
            .sink { response in
                if response.error == nil {
                    self.navigateToReport.toggle()
                } else {
                    self.navigateToPayment.toggle()
                }
            }.store(in: &cancellableSet)
    }
    
    func checkRelationshipReport() {
        dataManager.checkReportStatusForRelationship(token: token, firstDate: "\(firstReportMonth) \(firstReportDay)", secondDate: "\(secondReportMonth) \(secondReportDay)")
            .sink { response in
                if response.error == nil {
                    self.navigateToReport.toggle()
                } else {
                    self.navigateToPayment.toggle()
                }
            }.store(in: &cancellableSet)
    }
}
