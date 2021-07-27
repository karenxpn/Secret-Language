//
//  SettingsListCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import SwiftUI

struct SettingsListCell: View {
    
    let title: String
    let content: String
    
    var body: some View {
            HStack {
                VStack( alignment: .leading, spacing: 5) {
                    Text( title )
                        .foregroundColor(.gray)
                        .font(.custom("Gilroy-Regular", size: 10))
                    
                    Text( content )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 20))
                        .fontWeight(.semibold)
                    
                    Divider()
                }
                
                Image( "rightArrow" )
            }.padding()
    }
}

struct SettingsListCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListCell(title: NSLocalizedString("gender", comment: ""), content: NSLocalizedString("male", comment: ""))
    }
}
