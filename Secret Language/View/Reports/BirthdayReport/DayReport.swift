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
    
    var body: some View {
        VStack {
            VStack {
                
                Text( report.date_name )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 16))
                
                Text( report.day_name )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 22))
                    .fontWeight(.heavy)
                
                WebImage(url: URL(string: report.image ))
                    .placeholder {
                        ProgressView()
                    }.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .greedy, height: 150)
                    .padding()
                            
                HStack {
                    
                    VStack {
                        Text( report.s1 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 14))
                        
                        Text( report.s2 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 14))
                        
                        Text( report.s3 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 14))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text( report.w1 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 14))
                        
                        Text( report.w2 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 14))
                        
                        Text( report.w3 )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 14))
                    }
                }
                
            }.padding()
            .background(.white)
            .padding(.bottom)
            
            ReportSection(title: NSLocalizedString("meditation", comment: ""), content: report.meditation)
            
            ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
            
            ReportSection(title: NSLocalizedString("advice", comment: ""), content: report.advice)
            
            ReportSection(title: NSLocalizedString("health", comment: ""), content: report.health)
            
            ReportSection(title: NSLocalizedString("numerology", comment: ""), content: report.numbers)
            
            ReportSection(title: NSLocalizedString("archetype", comment: ""), content: report.archetype)
        }
    }
}

struct DayReport_Previews: PreviewProvider {
    static var previews: some View {
        DayReport(report: DayReportModel(id: 1, day: 21, date_name: "April Twenty-First", day_name: "The Day of Professional Commitment", day_name_short: "The Day of Professional Commitment", s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", meditation: "A civilization that regards nuclear energy as important and cooking as trivial is surely headed for destruction", report: "report", numbers: "Those born on th................", health: "April 21.......", advice: "Limit your .....", archetype: "The 21st card...", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
