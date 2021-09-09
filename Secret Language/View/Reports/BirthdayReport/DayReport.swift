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
    @State private var selection: String = "Personality"
    
    var body: some View {
        
        ZStack {
            Background()
            
            ScrollView( showsIndicators: false ) {

                PersonalityAndFamousTab(selection: $selection)
                
                VStack( alignment: .leading) {
                    VStack {
                        
                        Text( report.date_name )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 16))
                        
                        Text( report.day_name )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 22))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center)
                        
                        ImageHelper(image: report.image, contentMode: .fit, progressViewTintColor: .gray)
                            .frame(width: .greedy, height: 150)
                            .padding()
                        
                        SWViewHelper(s1: report.s1, s2: report.s2, s3: report.s3,
                                     w1: report.w1, w2: report.w2, w3: report.w3)
                        
                    }.padding()
                    .background(.white)
                    .padding(.bottom)
                    
                    if selection == "Personality" {
                        ReportSection(title: NSLocalizedString("meditation", comment: ""), content: report.meditation)
                        
                        ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
                        
                        ReportSection(title: NSLocalizedString("advice", comment: ""), content: report.advice)
                        
                        ReportSection(title: NSLocalizedString("health", comment: ""), content: report.health)
                        
                        ReportSection(title: NSLocalizedString("numerology", comment: ""), content: report.numbers)
                        
                        ReportSection(title: NSLocalizedString("archetype", comment: ""), content: report.archetype)
                    } else {
                        FamousList(famousList: report.famous)
                    }
                    
                    Spacer()
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.day_name), displayMode: .inline)
    }
}

struct DayReport_Previews: PreviewProvider {
    static var previews: some View {
        DayReport(report: DayReportModel(id: 1, day: 21, date_name: "April Twenty-First", day_name: "The Day of Professional Commitment", day_name_short: "The Day of Professional Commitment", s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", meditation: "A civilization that regards nuclear energy as important and cooking as trivial is surely headed for destruction", report: "report", numbers: "Those born on th................", health: "April 21.......", advice: "Limit your .....", archetype: "The 21st card...", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg", sln: "")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
