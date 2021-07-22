//
//  ContentView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI
import PusherSwift

struct SharedURL: Identifiable {
    var id: Int
    var type: String
}

struct ContentView: View {
    
    @StateObject var notificationsVM = NotificationsViewModel()
    @State private var currentTab: Int = 0
    @State private var shared: SharedURL?
    
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
            
            if value.type == "profile" {
                SharedProfile( userID: value.id )
            } else if value.type == "birthday" {
                SharedBirthdayReport( reportID: value.id )
            } else {
                SharedRelationshipReport( reportID: value.id )
            }
        }.onOpenURL(perform: { (url) in
            
            let URL = url.absoluteString
            let sharedID = URL.extractDigits()
            
            if URL.contains("profile") {
                shared = SharedURL(id: sharedID, type: "profile" )
            } else if URL.contains("birthday") {
                shared = SharedURL(id: sharedID, type: "birthday" )
            } else if URL.contains("relationship") {
                shared = SharedURL(id: sharedID, type: "relationship" )
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
