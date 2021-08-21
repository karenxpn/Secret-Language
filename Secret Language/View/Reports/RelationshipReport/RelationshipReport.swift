//
//  RelationshipReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 05.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RelationshipReport: View {
    @Binding var report: RelationshipReportModel?
    
    var body: some View {
        ZStack {
            Background()
            
            if report != nil {
                ScrollView( showsIndicators: false ) {
                    
                    RelationshipReportInnerView(report: report!)
                    
                }.padding(.top, 1)
            }
        }.navigationBarTitle("")
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("relationshipBetween", comment: "")), displayMode: .inline)
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
        let url = URL(string: "https://secretlanguage.network/v1/relationship/share?id=\(id)")!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct RelationshipReport_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipReport(report: .constant( PreviewParameters.relationshipReport ) )
    }
}
