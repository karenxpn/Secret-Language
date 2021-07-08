//
//  SearchNavBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import SwiftUI

struct SearchNavBar: View {
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.custom("Gilroy-Bold", size: 16))
    }
}

struct SearchNavBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchNavBar(title: "title")
    }
}
