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
        WeekReport(report: WeekReportModel(id: 2, date_span: "Apr. 19-24", name_long: "Week of Power", report: "Report", advice: "Try not to ....",  s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
