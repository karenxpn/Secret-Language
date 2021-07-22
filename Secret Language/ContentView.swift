//
//  ContentView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI
import PusherSwift

enum SharedURL: Identifiable {
    var id: Self { self }

    case profile
    case birthday
    case relationship
}

struct ContentView: View {
    
    @StateObject var notificationsVM = NotificationsViewModel()
    @State private var currentTab: Int = 0
    @State private var shared: SharedURL? = .none
    @State private var sharedID = 0
    
    var body: some View {
        ZStack( alignment: .bottom) {
            
            Background()
            VStack {
                
                if currentTab == 0 {
                    Matches()
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else if currentTab == 1 {
                    Reports()
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else if currentTab == 2 {
                    Search()
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else if currentTab == 3 {
                    Chat()
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else if currentTab == 4 {
                    Profile()
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
            }
        
            CustomTabBar( currentTab: $currentTab )
            
        }.edgesIgnoringSafeArea(.bottom)
        .onAppear {
            notificationsVM.requestPermission()
        }.fullScreenCover(item: $shared) { value in
            if value == .profile {
                SharedProfile( userID: sharedID )
            } else if value == .birthday {
                SharedBirthdayReport( reportID: sharedID )
            } else {
                SharedRelationshipReport( reportID: sharedID )
            }
        }.onOpenURL(perform: { (url) in
            
            let URL = url.absoluteString
            
            if URL.contains("profile") {
                shared = .profile
            } else if URL.contains("birthday") {
                shared = .birthday
            } else if URL.contains("relationship") {
                shared = .relationship
            }
            
            sharedID = URL.extractDigits()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
