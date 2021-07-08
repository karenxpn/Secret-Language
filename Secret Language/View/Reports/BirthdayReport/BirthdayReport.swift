//
//  SingleReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import SwiftUI


struct BirthdayReport: View {
    
    @Binding var report: BirthdayReportModel?
    
    var body: some View {
        ZStack {
            Background()
            
            if report != nil {
                ScrollView( showsIndicators: false ) {
                    
                    // some report texts here
                    
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                    
                    LazyVGrid(columns: columns, alignment: .center) {
                            ReportGridItem(title: report!.day_report.date_name, image: report!.day_report.image, name: report!.day_report.day_name, destination: AnyView( DayReport( report: report!.day_report ) ))
                        
                        ReportGridItem(title: report!.week_report.date_span, image: report!.week_report.image, name: report!.week_report.name_long, destination: AnyView(WeekReport(report: report!.week_report)))
                        
                            ReportGridItem(title: report!.month_report.span1, image: report!.month_report.image, name: report!.month_report.name, destination: AnyView(MonthReport(report: report!.month_report)))
                        
                            ReportGridItem(title: report!.season_report.span1, image: report!.season_report.image, name: report!.season_report.name, destination: AnyView(SeasonReport(report: report!.season_report)))
                        
                    }.padding(.horizontal, 8)
                    
                }.padding( .top, 1)
            }
            
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("birthdayReport", comment: "")), displayMode: .inline)
    }
}

struct BirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayReport(report: .constant(BirthdayReportModel(id: 1, date_name: "April 21", day_report: DayReportModel(id: 1, day: 21, date_name: "April Twenty-First", day_name: "The Day of Professional Commitment", day_name_short: "The Day of Professional Commitment", s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", meditation: "A civilization that regards nuclear energy as important and cooking as trivial is surely headed for destruction", report: "report", numbers: "Those born on th................", health: "April 21.......", advice: "Limit your .....", archetype: "The 21st card...", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"), week_report: WeekReportModel(id: 2, date_span: "Apr. 19-24", name_long: "Week of Power", report: "Report", advice: "Try not to ....",  s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"),month_report: MonthReportModel(id: 3, span1: "April 21—May 21", name: "Nurturer", sign: "Taurus", season: "Initiators", mode: "Sensation", motto: "I Have, ", report: "The Month of the ....", personality: "If Taurus signig.....", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"), season_report: SeasonReportModel(id: 4, name: "Initiation", description: "Initiatiors", span1: "March 21–June 21", season_name: "Spring", activity: "Initiators who begin the whole process; starter-uppers who get things going", report: "The beginning........", faculty: "Intuition", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))) )
    }
}
