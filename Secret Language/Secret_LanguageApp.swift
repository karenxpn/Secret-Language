//
//  Secret_LanguageApp.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI
import SDWebImageSwiftUI

@main
struct Secret_LanguageApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Environment(\.scenePhase) private var phase
    
    @AppStorage( "newRelease" ) private var newRelease: Bool = true
    @AppStorage( "token" ) private var token = ""
    
    init() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.setBackIndicatorImage(UIImage(named: "back")?.withTintColor(UIColor(AppColors.accentColor)), transitionMaskImage: UIImage(named: "back"))
        newAppearance.configureWithOpaqueBackground()
        newAppearance.backgroundColor = .none
        newAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, .font: UIFont( name: "Gilroy-Regular", size: 20)!]
        UINavigationBar.appearance().standardAppearance = newAppearance
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(.white)
        
        if newRelease {
            self.token = ""
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if token != "" {
                ContentView()
            } else {
                Introduction()
            }
        }.onChange(of: phase) { newScene in
            switch newScene {
            case .active:
                UIApplication.shared.applicationIconBadgeNumber = 0
            default:
                break
            }
        }
    }
}
