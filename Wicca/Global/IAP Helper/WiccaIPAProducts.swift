//
//  WiccaIPAProducts.swift
//  Wicca
//
//  Created by Jay Jariwala on 12/04/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

public struct WiccaIPAProducts {
    
    public static let iapSharedSecrete = "3a80f92c8f0a4f6c83caedae5f9aff53"
    public static let unlocakWiccaYearly = "com.bigideaapps.Wikka.inapp.subscription.yearly"
    public static let unlocakWiccaLifetime = "com.bigideaapps.Wikka.inapp.lifeline"
    public static let unlocakWiccaMonthly = "com.bigideaapps.Wikka.inapp.subscription.monthly"
    
    private static let productIdentifiers: Set<ProductID> = [WiccaIPAProducts.unlocakWiccaYearly, WiccaIPAProducts.unlocakWiccaLifetime, WiccaIPAProducts.unlocakWiccaMonthly]
    
    public static let store = IAPManager(productIDs: WiccaIPAProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}
