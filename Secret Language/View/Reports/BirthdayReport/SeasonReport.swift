//
//  SeasonReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SeasonReport: View {
    
    @EnvironmentObject var shareReportVM: ShareReportViewModel
    let report: SeasonReportModel
    
    var body: some View {
        
        ZStack {
            Background()
            
            ScrollView( showsIndicators: false ) {
                VStack( alignment: .leading) {
                    VStack {
                        
                        Text( report.span1 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 18))
                            .fontWeight(.semibold)

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
                    
                    ReportSection(title: NSLocalizedString("description", comment: ""), content: report.description, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("faculty", comment: ""), content: report.faculty, orientation: 2)
                    
                    ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)

        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.name), displayMode: .inline)
    }
}

struct SeasonReport_Previews: PreviewProvider {
    static var previews: some View {
        SeasonReport(report: SeasonReportModel(id: 4, name: "Initiation", description: "Initiatiors", span1: "March 21–June 21", season_name: "Spring", activity: "Initiators who begin the whole process; starter-uppers who get things going", report: "The beginning........", faculty: "Intuition", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
