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
    @EnvironmentObject var shareReportVM: ShareReportViewModel
    
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
        DayReport(report: DayReportModel(id: 1, day: 21, date_name: "April Twenty-First", day_name: "The Day of Professional Commitment", day_name_short: "The Day of Professional Commitment", s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", meditation: "A civilization that regards nuclear energy as important and cooking as trivial is surely headed for destruction", report: "report", numbers: "Those born on th................", health: "April 21.......", advice: "Limit your .....", archetype: "The 21st card...", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
