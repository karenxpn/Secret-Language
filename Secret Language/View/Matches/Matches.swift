//
//  Matches.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Matches: View {
    var body: some View {
        ZStack {
            ForEach( Card.data ) { card in
                SingleMatch(card: CardViewModel(card: card))
                    .padding(8)
            }
        }
    }
}

struct Matches_Previews: PreviewProvider {
    static var previews: some View {
        Matches()
    }
}
