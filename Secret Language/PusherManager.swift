//
//  PusherManager.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.06.21.
//

import Foundation
import PusherSwift
import SwiftUI

class PusherManager {

    static let shared = PusherManager()
    
    var pusher: Pusher!
    let channel: PusherChannel!

    private init() {
        @AppStorage( "username" ) var username: String = ""
        
        let options = PusherClientOptions(
            autoReconnect: true,
            host: .cluster(Credentials.pusher_cluster)
        )
        
        self.pusher = Pusher(key: Credentials.pusher_key, options: options)
        pusher.connect()
        self.channel = pusher.subscribe(username)
    }
}
