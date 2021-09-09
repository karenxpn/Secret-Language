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
                
                HStack {
                    Spacer()
                    
                    Text( NSLocalizedString(title, comment: ""))
                        .font(.custom("times", size: 18))
                        .foregroundColor(.accentColor)
                    
                    Spacer()
                }
                
                Text( content )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 16))
                
            }.padding(.horizontal, 10)
            .fixedSize(horizontal: false, vertical: true)
        } else {
            HStack {
                Text( NSLocalizedString(title, comment: ""))
                    .font(.custom("times", size: 18))
                    .foregroundColor(.accentColor) +
                    
                    Text( content )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 18))
            }.padding(.horizontal, 10)

        }
    }
}

struct ReportSection_Previews: PreviewProvider {
    static var previews: some View {
        ReportSection(title: "Advice", content: "Advice", orientation: 1)
    }
}
