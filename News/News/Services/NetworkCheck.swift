//
//  NetworkCheck.swift
//  News
//
//  Created by Aj on 16/07/24.
//

import Foundation
import Network

class NetworkCheck {
    
    static let shared = NetworkCheck()
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    
    private init() {
        monitor = NWPathMonitor()
        monitor.start(queue: queue)
        setupPathUpdateHandler()
    }
    
    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    private func setupPathUpdateHandler() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("We're connected!")
                NotificationCenter.default.post(name: .networkStatusChanged, object: nil, userInfo: ["isConnected": true])
            } else {
                print("No connection.")
                NotificationCenter.default.post(name: .networkStatusChanged, object: nil, userInfo: ["isConnected": false])
            }
            print("Is connection expensive: \(path.isExpensive)")
        }
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
}
