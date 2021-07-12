//
//  PaymentOrReportDetectionView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 13.07.21.
//

import SwiftUI

struct PaymentOrReportDetectionView: View {
    
    @AppStorage( "shouldPurchase" ) private var shouldPurchase: Bool = true
    @EnvironmentObject var reportVM: ReportViewModel
    @Binding var birthdayOrRelationship: Bool
    
    var body: some View {
        if shouldPurchase {
            PaymentView( birthdayDate: "\(reportVM.birthdayMonth) \(reportVM.birthday)",
                                                     firstReportDate: "\(reportVM.firstReportMonth) \(reportVM.firstReportDay)",
                                                     secondReportDate: "\(reportVM.secondReportMonth) \(reportVM.secondReportDay)",
                                                     birthdayOrRelationship: $birthdayOrRelationship)
        } else {
            if birthdayOrRelationship {
                RelationshipReport(report: $reportVM.relationshipReport)
            } else {
                BirthdayReport(report: $reportVM.birthdayReport)
            }
        }
    }
}

struct PaymentOrReportDetectionView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOrReportDetectionView(birthdayOrRelationship: .constant(false))
    }
}
