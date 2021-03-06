//
//  PathReportInnerView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 12.10.21.
//

import SwiftUI

struct PathReportInnerView: View {
    let report: PathReportModel

    var body: some View {
        ScrollView( showsIndicators: false ) {
            
            VStack( alignment: .leading, spacing: 10 ) {
                VStack( spacing: 10 ) {
                    
                    Text( report.name_long )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 18))
                        .fontWeight(.semibold)
                    
                    Text( report.way_name )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 16))
                        .fontWeight(.semibold)
                                            
                    ImageHelper(image: report.image, contentMode: .fit, progressViewTintColor: .gray)
                        .frame(width: .greedy, height: 150)
                        .padding()
                    
                    Text( report.prefix + report.name_long )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 22))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
         
                }.padding()
                .background(.white)
                .padding(.bottom)
                
                ReportSection(title: NSLocalizedString("challenge", comment: ""), content: report.challenge, orientation: 2)
                
                ReportSection(title: NSLocalizedString("fulfillment", comment: ""), content: report.fulfillment, orientation: 2)
                
                ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
                
                Spacer()
            }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            
        }.padding(.top, 1)
    }
}
