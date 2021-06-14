//
//  FilterMatches.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 15.06.21.
//

import SwiftUI

struct FilterMatches: View {
    var body: some View {
        ZStack {
            Background()
        }.navigationBarTitle("")
        .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("dataFilters", comment: "")))
    }
}

struct FilterMatches_Previews: PreviewProvider {
    static var previews: some View {
        FilterMatches()
    }
}
