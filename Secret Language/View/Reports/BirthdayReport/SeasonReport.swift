//
//  SeasonReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeasonReport: View {
    
    @EnvironmentObject var shareReportVM: SharedReportViewModel
    let report: SeasonReportModel
    
    var body: some View {
        
        ZStack {
            Background()
            SeasonReportInnerView(report: report)
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.name), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    shareReportVM.shareReport(type: "season",
                                                              reportID: report.id)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                })
                            )
    }
}

struct SeasonReport_Previews: PreviewProvider {
    static var previews: some View {
        SeasonReport(report: PreviewParameters.seasonReport)
    }
}
