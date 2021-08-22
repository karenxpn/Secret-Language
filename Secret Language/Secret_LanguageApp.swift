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
    @Environment(\.scenePhase) var scenePhase
    
    @AppStorage( "newRelease" ) private var newRelease: Bool = true
    @AppStorage( "token" ) private var token = ""
    
    init() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.setBackIndicatorImage(UIImage(named: "back"), transitionMaskImage: UIImage(named: "back"))
        newAppearance.configureWithOpaqueBackground()
        newAppearance.backgroundColor = .none
        newAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, .font: UIFont( name: "Gilroy-Regular", size: 20)!]
        UINavigationBar.appearance().standardAppearance = newAppearance
        
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor(.white)
        
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        
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
        }.onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
                
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
