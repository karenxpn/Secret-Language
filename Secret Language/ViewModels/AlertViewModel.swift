//
//  AlertViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 13.10.21.
//

import Foundation
class AlertViewModel {
    func makeAlert(with error: NetworkError, message: inout String, alert: inout Bool ) {
        message = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        alert.toggle()
    }
    
    func makeSuccessAlert( with response: GlobalResponse, showAlert: inout Bool, alertMessage: inout String ) {
        alertMessage = response.message
        showAlert.toggle()
    }
    
    func makeReportAlert( response: GlobalResponse, alert: inout Bool, message: inout String, type: inout UserStatusChangeAlert? ) {
        message = response.message
        type = .report
        alert.toggle()
    }
}
