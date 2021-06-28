//
//  VisitedProfile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import SwiftUI

struct VisitedProfile: View {
    
    var body: some View {
        ZStack {
            Background()
            
            Text( "Visited Profile" )
        }.navigationBarTitle("")
        .navigationBarTitleView(SearchNavBar(title: "Visited Profile"))
    }
}

struct VisitedProfile_Previews: PreviewProvider {
    static var previews: some View {
        VisitedProfile()
    }
}
