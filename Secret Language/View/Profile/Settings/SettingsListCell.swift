//
//  SettingsListCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 27.07.21.
//

import SwiftUI

struct SettingsListCell: View {
    
    let destination: AnyView
    let title: String
    let content: String
    let navigationEnabled: Bool
    
    var body: some View {
        NavigationLink(destination: destination) {
            
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
        }.disabled(!navigationEnabled)
    }
}

struct SettingsListCell_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListCell(destination: AnyView(EmptyView()), title: NSLocalizedString("gender", comment: ""), content: NSLocalizedString("male", comment: ""), navigationEnabled: false)
    }
}
