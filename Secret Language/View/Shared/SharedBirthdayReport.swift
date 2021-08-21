//
//  SharedBirthdayReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import SwiftUI

struct SharedBirthdayReport: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var reportVM = ReportViewModel()
    let reportID: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if reportVM.loading {
                    ProgressView()
                } else if reportVM.birthdayReport != nil {
                    ScrollView( showsIndicators: false ) {
                        BirthdayReportInnerView(report: reportVM.birthdayReport!)
                    }.padding(.top, 1)
                }
                
            }.navigationBarTitle( "" )
            .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("birthdayReport", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
                
            })
            ).onAppear {
                reportVM.getSharedBirthdayReport(reportID: reportID)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SharedBirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        SharedBirthdayReport(reportID: 1)
    }
}
