//
//  ContentView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage( "token" ) private var token: String = ""
    var body: some View {
        Button {
            self.token = ""
        } label: {
            Text( "Logout")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
