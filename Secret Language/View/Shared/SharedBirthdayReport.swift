//
//  SharedBirthdayReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import SwiftUI

struct SharedBirthdayReport: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var reportVM = SharedReportViewModel()
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
                
                CustomAlert(isPresented: $reportVM.showAlert, alertMessage: reportVM.alertMessage, alignment: .center)
                    .offset(y: reportVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
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
