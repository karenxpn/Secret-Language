//
//  SeasonReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeasonReport: View {
    let report: SeasonReportModel
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    
                    Text( report.name )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 16))
                    
                    Text( report.span1 )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 18))
                        .fontWeight(.semibold)

                    
                    WebImage(url: URL(string: report.image ))
                        .placeholder {
                            ProgressView()
                        }.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: .greedy, height: 150)
                        .padding()
                    
                    
                    Text( report.name )
                        .foregroundColor(.black)
                        .font(.custom("times", size: 22))
                        .fontWeight(.heavy)
                    
                }.padding()
                .background(.white)
                .padding(.bottom)
                
                ReportSection(title: NSLocalizedString("description", comment: ""), content: report.description)
                
                ReportSection(title: NSLocalizedString("faculty", comment: ""), content: report.faculty)
                
                ReportSection(title: NSLocalizedString("motivation", comment: ""), content: report.motivation)

                ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
            }
        }
    }
}

struct SeasonReport_Previews: PreviewProvider {
    static var previews: some View {
        SeasonReport(report: SeasonReportModel(id: 4, name: "Initiation", description: "Initiatiors", span1: "March 21–June 21", season_name: "Spring", activity: "Initiators who begin the whole process; starter-uppers who get things going", report: "The beginning........", faculty: "Intuition", motivation: "Motivation", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
