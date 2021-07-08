//
//  PaymentViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 09.07.21.
//

import Foundation
import SwiftUI
import Combine

class PaymentViewModel: ObservableObject {
    @AppStorage( "token" ) private var token: String = ""
    @Published var birthdayDate: String = ""
    @Published var firstReportDate: String = ""
    @Published var secondReportDate: String = ""
    @Published var birthdayOrReport: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: PaymentServiceProtocol
    
    init(dataManager: PaymentServiceProtocol = PaymentService.shared) {
        self.dataManager = dataManager
    }
    
    func postPaymentResult() {
        dataManager.postPaymentStatus(token: token, reportDate: birthdayDate, firstReportDate: firstReportDate, secondReportDate: secondReportDate, birthdayOrReport: birthdayOrReport)
            .sink { response in
                print(response)
            }.store(in: &cancellableSet)
        
    }
}
