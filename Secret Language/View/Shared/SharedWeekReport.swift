//
//  SharedWeekReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 12.10.21.
//

import SwiftUI

struct SharedWeekReport: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var reportVM = SharedReportViewModel()
    let reportID: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if reportVM.loading {
                    ProgressView()
                } else if reportVM.weekReport != nil {
                    WeekReportInnerView(report: reportVM.weekReport!)
                }
                
                CustomAlert(isPresented: $reportVM.showAlert, alertMessage: reportVM.alertMessage, alignment: .center)
                    .offset(y: reportVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.navigationBarTitle( "" )
            .navigationBarTitleView(SearchNavBar(title: "Week Report"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
                
            })).onAppear {
                reportVM.getSharedWeekReport(reportID: reportID)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
