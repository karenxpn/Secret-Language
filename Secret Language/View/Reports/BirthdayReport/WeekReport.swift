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
    @EnvironmentObject var shareReportVM: ShareReportViewModel
    @State private var selection: String = "Personality"
    
    var body: some View {
        
        ZStack {
            Background()
            
            ScrollView( showsIndicators: false ) {
                PersonalityAndFamousTab(selection: $selection)
                
                VStack( alignment: .leading) {
                    VStack {
                        VStack {
                            
                            Text( report.date_span )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                            
                            Text( report.name_long )
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
                            
                            ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
                            
                            ReportSection(title: NSLocalizedString("advice", comment: ""), content: report.advice)
                        } else {
                            FamousList(famousList: report.famous)
                        }
                    }
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)
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
