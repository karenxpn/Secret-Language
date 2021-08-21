//
//  SharedRelationshipReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SharedRelationshipReport: View {
    
    @ObservedObject var reportVM = ReportViewModel()
    @Environment(\.presentationMode) var presentationMode
    let reportID: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if reportVM.loading {
                    ProgressView()
                } else if reportVM.relationshipReport != nil {
                    
                    ScrollView( showsIndicators: false ) {
                        RelationshipReportInnerView(report: reportVM.relationshipReport!)
                    }.padding(.top, 1)
                }
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("relationshipBetween", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
            })).onAppear {
                reportVM.getSharedRelationshipReport(reportID: reportID)
            }
        }
        
    }
}

struct SharedRelationshipReport_Previews: PreviewProvider {
    static var previews: some View {
        SharedRelationshipReport(reportID: 1)
    }
}
