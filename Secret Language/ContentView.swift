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
    @StateObject private var paymentVM = PaymentViewModel()
    
    @Binding var currentTab: Int
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
            paymentVM.checkSubscriptionStatus()
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
        }).onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "notificationFetched"))) { action in
            
            if let decodedAction = action.object as? [String : String], let val = decodedAction["action"] {
                switch val {
                case Credentials.notificationsOpenChatAction:
                    currentTab = 3
                case Credentials.notificationsOpenProfileAction:
                    currentTab = 4
                case Credentials.norificationsOpenAppStore:
                    if let url = URL(string: Credentials.app_store_link) {
                        UIApplication.shared.open(url)
                    }
                default:
                    break
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentTab: .constant(2))
    }
}
