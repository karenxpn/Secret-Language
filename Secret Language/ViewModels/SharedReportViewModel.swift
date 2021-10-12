//
//  ShareReportViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 11.10.21.
//

import Foundation
import Combine
import SwiftUI

class SharedReportViewModel: ObservableObject {
    
    @Published var loading: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    
    @Published var relationshipReport: RelationshipReportModel? = nil
    @Published var birthdayReport: BirthdayReportModel? = nil
    @Published var dayReport: DayReportModel? = nil
    @Published var weekReport: WeekReportModel? = nil
    @Published var monthReport: MonthReportModel? = nil
    @Published var seasonReport: SeasonReportModel? = nil
    @Published var wayReport: WayReportModel? = nil
    @Published var pathReport: PathReportModel? = nil
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: ReportServiceProtocol
    
    init(dataManager: ReportServiceProtocol = ReportService.shared) {
        self.dataManager = dataManager
    }
    
    func getSharedBirthdayReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedBirthdayReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.birthdayReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedRelationshipReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedRelationshipReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.relationshipReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedDayReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedDayReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.dayReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedWeekReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedWeekReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.weekReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedMonthReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedMonthReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.monthReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedSeasonReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedSeasonReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.seasonReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedWayReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedWayReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.wayReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func getSharedPathReport( reportID: Int ) {
        loading = true
        dataManager.fetchSharedPathReport(reportID: reportID)
            .sink { response in
                self.loading = false
                if response.error != nil {
                    self.makeAlert(showAlert: &self.showAlert, message: &self.alertMessage, error: response.error!)
                } else {
                    self.pathReport = response.value!
                }
            }.store(in: &cancellableSet)
    }
    
    func makeAlert( showAlert: inout Bool, message: inout String, error: NetworkError ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        showAlert.toggle()
    }
    
    func shareReport( type: String, reportID: Int ) {
        let url = URL(string: "https://secretlanguage.network/v1/\(type)/share?id=\(reportID)")!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
