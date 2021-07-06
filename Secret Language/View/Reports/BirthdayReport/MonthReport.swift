//
//  MonthReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct MonthReport: View {
    
    let report: MonthReportModel
    
    var body: some View {
        VStack {
            VStack {
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
            }
        }
    }
}

struct MonthReport_Previews: PreviewProvider {
    static var previews: some View {
        MonthReport(report: MonthReportModel(id: 3, span1: "April 21—May 21", name: "Nurturer", sign: "Taurus", season: "Initiators", mode: "Sensation", motto: "I Have, ", report: "The Month of the ....", personality: "If Taurus signig.....", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
