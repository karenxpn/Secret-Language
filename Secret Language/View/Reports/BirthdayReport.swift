//
//  SingleReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import SwiftUI

struct BirthdayReport: View {
    @EnvironmentObject var report: ReportViewModel

    var body: some View {
        ZStack {
            Background()
            
            Text( "Birthday report" )
        }
    }
}

struct BirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayReport()
            .environmentObject(ReportViewModel())
    }
}
