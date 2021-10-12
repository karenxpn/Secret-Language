//
//  MonthReportInnerView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 12.10.21.
//

import SwiftUI

struct MonthReportInnerView: View {
    let report: MonthReportModel

    var body: some View {
        ScrollView( showsIndicators: false ) {
            VStack( alignment: .leading) {
                VStack {
                    
                    Text( report.span1 )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 16))

                    ImageHelper(image: report.image, contentMode: .fit, progressViewTintColor: .gray)
                        .frame(width: .greedy, height: 150)
                        .padding()
                    
                    Text( report.name )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 22))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                }.padding()
                .background(.white)
                .padding(.bottom)
                
                ReportSection(title: NSLocalizedString("theirMode", comment: ""), content: report.mode, orientation: 2)
                ReportSection(title: NSLocalizedString("motto", comment: ""), content: report.motto, orientation: 2)
                ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
            }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
        }.padding(.top, 1)
    }
}
