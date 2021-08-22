//
//  NotificationsViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.07.21.
//

import Foundation
import UIKit
import Combine
import SwiftUI
import UserNotifications

struct NotificationAlertModel: Codable {
    var alert: AlertModel
}

struct AlertModel: Codable {
    var action: String
}

class NotificationsViewModel: NSObject, UNUserNotificationCenterDelegate, ObservableObject {
    
    @AppStorage( "token" ) private var token: String = ""
    //    @AppStorage( "badge" ) private var badge: Int = 0
    @Published var changeToTab: Int = -1
    @Published var deviceToken: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    var dataManager: DeviceTokenManager
    
    init( dataManager: DeviceTokenManager = DeviceTokenManager.shared) {
        self.dataManager = dataManager
        super.init()
    }
    
    func sendDeviceToken() {
        dataManager.sendDeviceToken(token: token, deviceToken: deviceToken)
            .sink { (_) in
            } receiveValue: { (_) in
            }.store(in: &cancellableSet)
    }
    
    func requestPermission() {
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.badge,.alert, .sound]) { (granted, error) in
                if let error = error {
                    print(error)
                } else if granted {
                    DispatchQueue.main.async {
                        //                        UIApplication.shared.applicationIconBadgeNumber = self.badge
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
    }
    // foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        if let badge = notification.request.content.badge {
            UIApplication.shared.applicationIconBadgeNumber = Int(truncating: badge)
        }

        completionHandler([.banner, .sound, .badge])
    }
    
    // background // this is called when user taps on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let info = response.notification.request.content.userInfo
        
        if let first = info.first {
            let firstInfo = first.value
            
            let jsonData = try? JSONSerialization.data (withJSONObject: firstInfo, options: [])
            if let data = jsonData {
                guard let notification = try? JSONDecoder().decode(NotificationAlertModel.self, from: data) else {
                    return
                }
                
                print("action = \(notification.alert.action)")
                switch notification.alert.action {
                case "open.chats" :
                    self.changeToTab = 3
                case "open.profile":
                    self.changeToTab = 4
                default:
                    break
                }
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
}
