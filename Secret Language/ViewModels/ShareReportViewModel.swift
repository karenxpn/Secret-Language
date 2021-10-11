//
//  ShareReportViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 11.10.21.
//

import Foundation
import SwiftUI

class ShareReportViewModel: ObservableObject {
    
    func shareReport( type: String, reportID: Int ) {
        let url = URL(string: "https://secretlanguage.network/v1/\(type)/share?id=\(reportID)")!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
