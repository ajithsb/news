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
        setupPathUpdateHandler()
    }
    
    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
    
    private func setupPathUpdateHandler() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard self != nil else { return }
            let isConnected = path.status == .satisfied
            print(isConnected ? "We're connected!" : "No connection.")
            NotificationCenter.default.post(name: .networkStatusChanged, object: nil, userInfo: ["isConnected": isConnected])
            print("Is connection expensive: \(path.isExpensive)")
        }
        monitor.start(queue: queue)
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
