//
//  SeasonReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI

struct SeasonReport: View {
    let report: SeasonReportModel
    
    var body: some View {
        Text("Season Report")
    }
}

struct SeasonReport_Previews: PreviewProvider {
    static var previews: some View {
        SeasonReport(report: SeasonReportModel(id: 4, name: "Initiation", description: "Initiatiors", span1: "March 21–June 21", season_name: "Spring", activity: "Initiators who begin the whole process; starter-uppers who get things going", report: "The beginning........", faculty: "Intuition", image:  "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/day/150/png/111.png"))
    }
}
