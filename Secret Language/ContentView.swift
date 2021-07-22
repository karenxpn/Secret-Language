//
//  ContentView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI
import PusherSwift

enum SharedURL {
    case profile
    case birthday
    case relationship
}

struct ContentView: View {
    
    @StateObject var notificationsVM = NotificationsViewModel()
    @State private var currentTab: Int = 0
    @State private var shared: SharedURL? = .none
    @State private var openSharedSheet: Bool = false
    
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
        }.onOpenURL(perform: { (url) in
            
            print(url)
            
            if let urlComponents = URLComponents(string: url.absoluteString), let _ = urlComponents.host, let queryItems = urlComponents.queryItems {

                print( queryItems[0])
                let name = queryItems[0].name
                let value = queryItems[0].value
                
                if name == "profile" {
                    self.shared = .profile
                    self.openSharedSheet.toggle()
                }
            }
        })
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
