//
//  Matches.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Matches: View {
    var body: some View {
        
        NavigationView {
            ZStack {
                
                Background()
                ForEach( Card.data ) { card in
                    SingleMatch(card: CardViewModel(card: card))
                        .padding(.horizontal, 8)
                }
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle( "" )
            .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("matches", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(
                                    destination: FilterMatches(),
                                    label: {
                                        Image( "filterIcon" )
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }))
        }
        
    }
}

struct Matches_Previews: PreviewProvider {
    static var previews: some View {
        Matches()
    }
}
