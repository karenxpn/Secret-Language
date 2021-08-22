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
    var badge: Int
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
            .requestAuthorization(options: [.badge, .alert, .sound]) { (granted, error) in
                if let error = error {
                    print(error)
                } else if granted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
    }
    // foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .list, .sound])
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
        
        completionHandler()
    }
}


extension NotificationsViewModel: UIApplicationDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        debugPrint("Received: \(userInfo)")
        debugPrint("State: \(application.applicationState.rawValue)")
        
        let state = application.applicationState
        switch state {
        case .background:
            debugPrint("background")
            // update badge count here
            application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
        default:
            break
        }
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
