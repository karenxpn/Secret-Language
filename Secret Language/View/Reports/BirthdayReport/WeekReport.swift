//
//  WeekReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct WeekReport: View {
    
    let report: WeekReportModel
    @EnvironmentObject var shareReportVM: SharedReportViewModel
    
    var body: some View {
        
        ZStack {
            Background()
            WeekReportInnerView(report: report)
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.date_span), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    shareReportVM.shareReport(type: "week",
                                                              reportID: report.id)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                })
                            )
    }
}

struct WeekReport_Previews: PreviewProvider {
    static var previews: some View {
        WeekReport(report: PreviewParameters.weekReport)
    }
}
