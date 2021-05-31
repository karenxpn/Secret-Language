//
//  Secret_LanguageApp.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

@main
struct Secret_LanguageApp: App {
    
    @AppStorage( "token" ) private var token = ""
    
    
    var body: some Scene {
        WindowGroup {
            if token != "" {
                ContentView()
            } else {
                Introduction()
            }
        }
    }
}
