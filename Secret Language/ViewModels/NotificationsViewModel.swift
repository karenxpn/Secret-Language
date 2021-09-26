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
}
