//
//  MatchesNavBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.06.21.
//

import SwiftUI

struct MatchesNavBar: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.custom("Gilroy-Bold", size: 17))
    }
}

struct MatchesNavBar_Previews: PreviewProvider {
    static var previews: some View {
        MatchesNavBar(title: "Matches")
    }
}
