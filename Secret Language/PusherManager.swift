//
//  PusherManager.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.06.21.
//

import Foundation
import PusherSwift
class PusherManager {

    static let shared = PusherManager()
    
    var pusher: Pusher!

    private init() {
        let options = PusherClientOptions(
            host: .cluster(Credentials.pusher_cluster)
        )
        
        self.pusher = Pusher(key: Credentials.pusher_key, options: options)
        pusher.connect()
    }

}
