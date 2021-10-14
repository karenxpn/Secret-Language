//
//  WeekReportInnerView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 12.10.21.
//

import SwiftUI

struct WeekReportInnerView: View {
    let report: WeekReportModel
    @State private var selection: String = "Personality"

    var body: some View {
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
    }
}
