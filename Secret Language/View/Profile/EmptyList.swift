//
//  EmptyList.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.06.21.
//

import SwiftUI

struct EmptyList: View {
    var body: some View {
        VStack( spacing: 20) {
            
            Image( "emptyList" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            
            Text( NSLocalizedString("emptyList", comment: ""))
                .foregroundColor(.white)
                .font(.custom("Avenir", size: 18))
                .multilineTextAlignment(.center)
        }.padding()
    }
}

struct EmptyList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyList()
    }
}
