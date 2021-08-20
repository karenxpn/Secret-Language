//
//  AllRightsReservedMadeByDoejo.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 20.08.21.
//

import SwiftUI

struct AllRightsReservedMadeByDoejo: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack( spacing: 5) {
                Text( NSLocalizedString("rightsReserved", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("Gilroy-Regular", size: 10))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                
                Link(NSLocalizedString("madeByDoejo", comment: ""), destination: URL(string: "https://doejo.com")!)
                    .foregroundColor(.blue)
                    .font(.custom("Gilroy-Regular", size: 10))
            }

            Spacer()
        }
    }
}

struct AllRightsReservedMadeByDoejo_Previews: PreviewProvider {
    static var previews: some View {
        AllRightsReservedMadeByDoejo()
    }
}
