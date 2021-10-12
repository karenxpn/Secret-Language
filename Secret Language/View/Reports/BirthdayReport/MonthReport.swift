//
//  MonthReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MonthReport: View {
    
    @EnvironmentObject var shareReportVM: SharedReportViewModel
    let report: MonthReportModel
    
    var body: some View {
        
        ZStack {
            Background()
            MonthReportInnerView(report: report)
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.name), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    shareReportVM.shareReport(type: "month",
                                                              reportID: report.id)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                })
                            )
    }
}

struct MonthReport_Previews: PreviewProvider {
    static var previews: some View {
        MonthReport(report: MonthReportModel(id: 3, span1: "April 21—May 21", name: "Nurturer", sign: "Taurus", season: "Initiators", mode: "Sensation", motto: "I Have, ", report: "The Month of the ....", personality: "If Taurus signig.....", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
