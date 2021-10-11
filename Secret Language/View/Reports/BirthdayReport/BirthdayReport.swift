//
//  SingleReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import SwiftUI


struct BirthdayReport: View {
    
    @StateObject var shareReportVM = ShareReportViewModel()
    @Binding var report: BirthdayReportModel?
    
    var body: some View {
        ZStack {
            Background()
            
            if report != nil {
                ScrollView( showsIndicators: false ) {

                    BirthdayReportInnerView(report: report!)
                        .environmentObject(shareReportVM)
                }.padding(.top, 1)
            }
            
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("birthdayReport", comment: "")), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    shareReportVM.shareReport(type: "birthday",
                                                              reportID: report!.shareId)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                }).disabled(report == nil)
        )
    }
}

struct BirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayReport(report: .constant(PreviewParameters.birthdayReport))
    }
}
