//
//  Background.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct Background: View {
    var body: some View {
        Color(UIColor(red: 5/255, green: 14/255, blue: 23/255, alpha: 1))
            .edgesIgnoringSafeArea(.all)
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
