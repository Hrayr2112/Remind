//
//  ReachabilityManager.swift
//  Remind
//
//  Created by Aram Sargsyan on 6/6/20.
//  Copyright © 2020 Remind. All rights reserved.
//

import Alamofire

class ReachabilityManager: NSObject {
    
    static let afReachabilityManager = Alamofire.NetworkReachabilityManager(host: "google.com")!
    
    static func isNetworkReachable() -> Bool {
        return afReachabilityManager.isReachable
    }
    
}
