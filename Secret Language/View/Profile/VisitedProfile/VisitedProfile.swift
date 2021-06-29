//
//  VisitedProfile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 28.06.21.
//

import SwiftUI

struct VisitedProfile: View {
    
    let userID: Int
    let userName: String
    
    var body: some View {
        ZStack {
            Background()
            
            Text( "Visited Profile" )
        }.navigationBarTitle("")
        .navigationBarTitleView(SearchNavBar(title: userName))
        .onAppear {
            // perform api request to get the user
        }
    }
}

struct VisitedProfile_Previews: PreviewProvider {
    static var previews: some View {
        VisitedProfile(userID: 1, userName: "John Smith")
    }
}
