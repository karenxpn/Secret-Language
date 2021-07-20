//
//  AppDelegate.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.07.21.
//

import Foundation
import SwiftUI

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    @ObservedObject var notificationsVM = NotificationsViewModel()
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken
            .map{ String( format: "%02.2hhx", $0)}
            .joined()
        
        notificationsVM.deviceToken = token
        notificationsVM.sendDeviceToken()
    }
}
