//
//  DayReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DayReport: View {
    let report: DayReportModel
    @EnvironmentObject var shareReportVM: SharedReportViewModel
    
    var body: some View {
        
        ZStack {
            Background()
            
            DayReportInnerView(report: report)

        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.day_name), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    shareReportVM.shareReport(type: "day",
                                                              reportID: report.id)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                })
                            )
    }
}

struct DayReport_Previews: PreviewProvider {
    static var previews: some View {
        DayReport(report: PreviewParameters.dayReport)
    }
}
