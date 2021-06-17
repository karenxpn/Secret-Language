//
//  Profile.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Profile: View {
    @AppStorage( "token" ) private var token: String = ""
    
    var body: some View {
        Button {
            self.token = ""
        } label: {
            Text( "Log out" )
                .foregroundColor(.white)
                .padding()
        }

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
