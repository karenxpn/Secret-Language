//
//  ReportSection.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 06.07.21.
//

import SwiftUI

struct ReportSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack ( spacing: 10 ) {
            Text( NSLocalizedString(title, comment: ""))
                .font(.custom("times", size: 18))
                .foregroundColor(.accentColor)
            
            LabelAlignment(text: content, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
        }
    }
}

struct ReportSection_Previews: PreviewProvider {
    static var previews: some View {
        ReportSection(title: "Advice", content: "Advice")
    }
}
