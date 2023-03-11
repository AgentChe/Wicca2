//
//  RefreshManager.swift
//  Wicca
//
//  Created by Jay Jariwala on 12/04/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

class RefreshManager: NSObject {
    
    static let shared = RefreshManager()
    private let defaults = UserDefaults.standard
    private let showExpireReminderUFKey = "showExpireReminder"
    private let calender = Calendar.current
    
    // MARK: - For Show expired reminder once in day
    func showExpiredReminderIfNeeded(completion: (Bool) -> Void) {
        if isExpiredReminderRequired() {
            // load the data
            defaults.set(Date(), forKey: showExpireReminderUFKey)
            completion(true)
        } else {
            completion(false)
        }
    }

    private func isExpiredReminderRequired() -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: showExpireReminderUFKey) as? Date else {
            return true
        }
        if let diff = calender.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, diff > 24 {
            return true
        } else {
            return false
        }
    }
    
}
