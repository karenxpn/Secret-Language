//
//  RelationshipReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 05.07.21.
//

import SwiftUI

struct RelationshipReport: View {
    @EnvironmentObject var report: ReportViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            Text( "Relationship report" )
        }
    }
}

struct RelationshipReport_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipReport()
            .environmentObject(ReportViewModel())
    }
}
