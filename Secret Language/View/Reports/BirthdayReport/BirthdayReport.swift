//
//  SingleReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import SwiftUI


struct BirthdayReport: View {
    
    @Binding var report: BirthdayReportModel?
    
    var body: some View {
        ZStack {
            Background()
            
            if report != nil {
                ScrollView( showsIndicators: false ) {

                    BirthdayReportInnerView(report: report!)
                }.padding(.top, 1)
            }
            
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("birthdayReport", comment: "")), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.shareReport(id: report!.shareId)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                }).disabled(report == nil)
        )
    }
    
    func shareReport( id: Int ) {
        let url = URL(string: "https://secretlanguage.network/v1/birthday/share?id=\(id)")!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct BirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayReport(report: .constant(PreviewParameters.birthdayReport))
    }
}
