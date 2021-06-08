//
//  AuthNavTitle.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 07.06.21.
//

import SwiftUI

struct AuthNavTitle: View {
    
    let title: String
    var body: some View {
        Text( title )
            .foregroundColor(.primary)
            .font(.custom("Gilroy-Regular", size: 20))
    }
}

struct AuthNavTitle_Previews: PreviewProvider {
    static var previews: some View {
        AuthNavTitle(title: "Verification")
    }
}
