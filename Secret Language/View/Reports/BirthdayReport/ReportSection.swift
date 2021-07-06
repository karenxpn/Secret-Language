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
    let orientation: Int
    
    init(title: String, content: String, orientation: Int = 1) {
        self.title = title
        self.content = content
        self.orientation = orientation
    }
    
    var body: some View {
        
        if orientation == 1 {
            VStack ( spacing: 10 ) {
                Text( NSLocalizedString(title, comment: ""))
                    .font(.custom("times", size: 18))
                    .foregroundColor(.accentColor)
                
                LabelAlignment(text: content, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
            }
        } else {
            HStack ( spacing: 0 ) {
                Text( NSLocalizedString(title, comment: ""))
                    .font(.custom("times", size: 18))
                    .foregroundColor(.accentColor)
                
                Text( content )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 18))
            }
        }
    }
}

struct ReportSection_Previews: PreviewProvider {
    static var previews: some View {
        ReportSection(title: "Advice", content: "Advice", orientation: 1)
    }
}
