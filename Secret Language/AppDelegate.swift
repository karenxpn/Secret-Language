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
    }
    
    // foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .list, .sound])
    }
    
    // background // this is called when user taps on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        if let action = userInfo["action"] as? String {
            NotificationCenter.default.post(name: Notification.Name("notificationFetched"), object: ["action" : action])
        }
        
        completionHandler()
    }
}
