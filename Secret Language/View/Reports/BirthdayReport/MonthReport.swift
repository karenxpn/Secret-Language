//
//  MonthReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI

struct MonthReport: View {
    
    let report: MonthReportModel
    
    var body: some View {
        Text("MonthReport")
    }
}

struct MonthReport_Previews: PreviewProvider {
    static var previews: some View {
        MonthReport(report: MonthReportModel(id: 3, span1: "April 21—May 21", name: "Nurturer", sign: "Taurus", season: "Initiators", mode: "Sensation", motto: "I Have, ", report: "The Month of the ....", personality: "If Taurus signig.....", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
