//
//  WayReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 08.07.21.
//

import SwiftUI

struct WayReport: View {
    
    let report: WayReportModel
    @EnvironmentObject var shareReportVM: SharedReportViewModel
    
    var body: some View {
        ZStack {
            Background()
            WayReportInnerView(report: report)

        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: report.name), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    shareReportVM.shareReport(type: "way",
                                                              reportID: report.id)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                })
                            )
    }
}

struct FromToView: View {
    
    let from: String
    let to: String
    
    var body: some View {
        HStack {
            
            Spacer()
            VStack {
                Text( "From" )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
                
                Text( from )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 16))
            }
            
            Spacer()
            
            VStack {
                Text( "To" )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 14))
                
                Text( to )
                    .foregroundColor(.black)
                    .font(.custom("times", size: 16))
            }
            
            Spacer()
        }
    }
}
