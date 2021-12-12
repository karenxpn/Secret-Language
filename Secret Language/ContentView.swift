//
//  ContentView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI
import PusherSwift
import SwiftUIX

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
            self.sharedView(value: value)
        }.onOpenURL(perform: { (url) in
            
            let URL = url.absoluteString
            let sharedID = URL.extractDigits()
                        
            self.checkURL(URL: URL, sharedID: sharedID)
            
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
    
    func checkURL(URL: String, sharedID: Int) {
        if URL.contains("profile") {
            shared = SharedURL(id: sharedID, type: "profile" )
        } else if URL.contains("birthday") {
            shared = SharedURL(id: sharedID, type: "birthday" )
        } else if URL.contains("relationship") {
            shared = SharedURL(id: sharedID, type: "relationship" )
        } else if URL.contains("day") {
            shared = SharedURL(id: sharedID, type: "day")
        } else if URL.contains("week") {
            shared = SharedURL(id: sharedID, type: "week")
        } else if URL.contains("month") {
            shared = SharedURL(id: sharedID, type: "month")
        } else if URL.contains("season") {
            shared = SharedURL(id: sharedID, type: "season")
        } else if URL.contains("way") {
            shared = SharedURL(id: sharedID, type: "way")
        } else if URL.contains("path") {
            shared = SharedURL(id: sharedID, type: "path")
        }
    }
    
    func sharedView(value: SharedURL) -> some View {
        switch value.type {
        case "profile":
            return AnyView(SharedProfile(userID: value.id))
        case "birthday":
            return AnyView(SharedBirthdayReport( reportID: value.id ))
        case "relationship":
            return AnyView(SharedRelationshipReport( reportID: value.id ))
        case "day":
            return AnyView(SharedDayReport(reportID: value.id))
        case "week":
            return AnyView(SharedWeekReport(reportID: value.id))
        case "month":
            return AnyView(SharedMonthReport(reportID: value.id))
        case "season":
            return AnyView(SharedSeasonReport(reportID: value.id))
        case "way":
            return AnyView(SharedWayReport(reportID: value.id))
        case "path":
            return AnyView(SharedPathReport(reportID: value.id))
        default:
            return AnyView(EmptyView())
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentTab: .constant(2))
    }
}
