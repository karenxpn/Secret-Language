//
//  PusherManager.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.06.21.
//

import Foundation
import PusherSwift
import SwiftUI

class PusherManager: PusherDelegate {
    
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
        pusher.connection.delegate = self
    }
    
    func debugLog(message: String) {
        print(message)
    }
    
    func changedConnectionState(from old: ConnectionState, to new: ConnectionState) {
        print("State changed from \(old.stringValue()) to \(new.stringValue())")
    }
}
