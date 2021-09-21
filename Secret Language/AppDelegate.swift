//
//  AppDelegate.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.07.21.
//

import Foundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    @ObservedObject var notificationsVM = NotificationsViewModel()
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken
            .map{ String( format: "%02.2hhx", $0)}
            .joined()
        
        notificationsVM.deviceToken = token
        notificationsVM.sendDeviceToken()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        completionHandler( .newData )
        let state = application.applicationState
        switch state {
        case .background:
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
        default:
            break
        }
        
        if let first = userInfo.first {
            let firstInfo = first.value
            
            let jsonData = try? JSONSerialization.data (withJSONObject: firstInfo, options: [])
            if let data = jsonData {
                guard let notification = try? JSONDecoder().decode(NotificationAlertModel.self, from: data) else {
                    return
                }
                
                switch notification.alert.action {
                case Credentials.notificationsOpenChatAction :
                    NotificationCenter.default.post(name: Notification.Name("notificationFetched"), object: ["action" : 3])
                case Credentials.notificationsOpenProfileAction:
                    NotificationCenter.default.post(name: Notification.Name("notificationFetched"), object: ["action" : 4])
                case Credentials.norificationsOpenAppStore:
                    NotificationCenter.default.post(name: Notification.Name("notificationFetched"), object: ["action" : 99])
//                    if let url = URL(string: Credentials.app_store_link) {
//                        UIApplication.shared.open(url)
//                    }
                default:
                    break
                }
            }
        }
    }
}
