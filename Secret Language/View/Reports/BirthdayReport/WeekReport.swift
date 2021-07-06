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
    @State private var selection: String = "Personality"
    
    var body: some View {
        VStack {
            PersonalityAndFamousTab(selection: $selection)
            
            VStack {
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
                        
                        WebImage(url: URL(string: report.image ))
                            .placeholder {
                                ProgressView()
                            }.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .greedy, height: 150)
                            .padding()
                        
                        HStack {
                            
                            VStack( alignment: .leading ) {
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
                            
                            VStack( alignment: .trailing ) {
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
                    
                    if selection == "Personality" {
                        
                        ReportSection(title: NSLocalizedString("personality", comment: ""), content: report.report)
                        
                        ReportSection(title: NSLocalizedString("advice", comment: ""), content: report.advice)
                    } else {
                        FamousList(famousList: report.famous)
                    }
                }
            }
        }
    }
}

struct WeekReport_Previews: PreviewProvider {
    static var previews: some View {
        WeekReport(report: WeekReportModel(id: 2, date_span: "Apr. 19-24", name_long: "Week of Power", report: "Report", advice: "Try not to ....",  s1: "Tasteful", s2: "Caring", s3: "Powerful", w1: "Profligate", w2: "Self-Indulgent", w3: "Over-Protective", famous: [FamousModel(id: 1, name: "Karen Mirakyan", age: "born 83 years ago", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/famous/4.jpg")], image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
