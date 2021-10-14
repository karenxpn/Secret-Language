//
//  WayReportInnerView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 12.10.21.
//

import SwiftUI

struct WayReportInnerView: View {
    @State private var selection: String = "Personality"
    let report: WayReportModel

    var body: some View {
        ScrollView( showsIndicators: false ) {
            
            PersonalityAndFamousTab(selection: $selection)
            
            VStack( alignment: .leading, spacing: 10) {
                VStack( spacing: 10 ) {
                    
                    Text( NSLocalizedString("theirLifeJourneyRuns", comment: "") )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 16))
                        .fontWeight(.semibold)
                    
                    FromToView(from: report.week_from, to: report.week_to)
                    
                    ImageHelper(image: report.image, contentMode: .fit, progressViewTintColor: .gray)
                        .frame(width: .greedy, height: 150)
                        .padding()
                    
                    Text( "\(NSLocalizedString("theWayOf", comment: "")) \(report.name)" )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 22))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                    
                    SWViewHelper(s1: report.s1, s2: report.s2, s3: report.s3,
                                 w1: report.w1, w2: report.w2, w3: report.w3)
                    
                }.padding()
                .background(.white)
                .padding(.bottom)
                
                if selection == "Personality" {
                    ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
                    
                    ReportSection(title: NSLocalizedString("suggestions", comment: ""), content: report.suggestion, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("lesson", comment: ""), content: report.lesson, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("goal", comment: ""), content: report.goal, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("needRelease", comment: ""), content: report.release, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("expectedReward", comment: ""), content: report.reward, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("mustLearnToBalance", comment: ""), content: report.balance, orientation: 2)
                    
                } else {
                    FamousList(famousList: report.famous)
                }
                
                Spacer()
            }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
        }.padding(.top, 1)
    }
}
