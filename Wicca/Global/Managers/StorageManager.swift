//
//  StorageManager.swift
//  Wicca
//
//  Created by Jay Jariwala on 26/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

import Foundation

struct StorageManager {
    
    static let shared = StorageManager()
    private init() { }
    
    // MARK: - Keys to Store, Retrieve, Remove Data from  UserDefaults
    private static let userDefaultsIsPremiumUser = APP_KEYS.kPremiumUser
    private static let userDefaultsuUnlocakWiccaPrice = APP_KEYS.kUnlockWiccaPrice
    private static let userDefaultsuUnlocakWiccaLocalePrice = APP_KEYS.kUnlockWiccaLocalePrice
    private static let userDefaultsuUnlocakWiccaLifetimePrice = APP_KEYS.kUnlockWiccaLifetimePrice
    private static let userDefaultsuUnlocakWiccaLifetimeLocalePrice = APP_KEYS.kUnlockWiccaLifetimeLocalePrice
    private static let userDefaultsuUnlocakWiccaMonthlyPrice = APP_KEYS.kUnlockWiccaMonthlyPrice
    private static let userDefaultsuUnlocakWiccaMonthlyLocalePrice = APP_KEYS.kUnlockWiccaMonthlyLocalePrice
}

// MARK: - Store & Retrive UserData from Userdefaults
extension StorageManager {
    
    public static func storeIsPremiumUser(isPremium: Bool) {
        UserDefaults.standard.set(isPremium, forKey: StorageManager.userDefaultsIsPremiumUser)
        UserDefaults.standard.synchronize()
    }
    
    public static var isPremiumUser: Bool {
        let isPremiumUser = UserDefaults.standard.bool(forKey: StorageManager.userDefaultsIsPremiumUser)
        return isPremiumUser
    }
    
    public static var unlockWiccaPrice: Float {
        let unlockGymstarPrice = UserDefaults.standard.float(forKey: StorageManager.userDefaultsuUnlocakWiccaPrice)
        return unlockGymstarPrice
    }
    
    public static var unlocakWiccaLocalePrice: String {
        let unlockGymstarPrice = UserDefaults.standard.string(forKey: StorageManager.userDefaultsuUnlocakWiccaLocalePrice) ?? ""
        return unlockGymstarPrice
    }
    
    public static var unlockWiccaLifetimePrice: Float {
        let unlockGymstarPrice = UserDefaults.standard.float(forKey: StorageManager.userDefaultsuUnlocakWiccaLifetimePrice)
        return unlockGymstarPrice
    }
    
    public static var unlocakWiccaLifetimeLocalePrice: String {
        let unlockGymstarPrice = UserDefaults.standard.string(forKey: StorageManager.userDefaultsuUnlocakWiccaLifetimeLocalePrice) ?? ""
        return unlockGymstarPrice
    }
    
    public static var unlockWiccaMonthlyPrice: Float {
        let unlockGymstarPrice = UserDefaults.standard.float(forKey: StorageManager.userDefaultsuUnlocakWiccaMonthlyPrice)
        return unlockGymstarPrice
    }
    
    public static var unlocakWiccaMonthlyLocalePrice: String {
        let unlockGymstarPrice = UserDefaults.standard.string(forKey: StorageManager.userDefaultsuUnlocakWiccaMonthlyLocalePrice) ?? ""
        return unlockGymstarPrice
    }
    
    public static func clearData() {
        UserDefaults.standard.synchronize()
    }
    
}
