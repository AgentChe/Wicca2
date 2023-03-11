//
//  IAPManager.swift
//  Wicca
//
//  Created by Jay Jariwala on 12/04/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation
import StoreKit
import SwiftyStoreKit

public typealias ProductID = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void
public typealias ProductPurchaseCompletionHandler = (_ success: Bool, _ productId: ProductID?) -> Void
public typealias ProductRestoreCompletionHandler = (_ success: Bool, _ productId: ProductID?) -> Void

// MARK: - IAPManager
public class IAPManager: NSObject  {
    private let productIDs: Set<ProductID>
    private var purchasedProductIDs: Set<ProductID>
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    private var productPurchaseCompletionHandler: ProductPurchaseCompletionHandler?
    private var productRestoreCompletionHandler: ProductRestoreCompletionHandler?
    
    public init(productIDs: Set<ProductID>) {
        self.productIDs = productIDs
        self.purchasedProductIDs = productIDs.filter { productID in
            let purchased = UserDefaults.standard.bool(forKey: productID)
            if purchased {
                print("Previously purchased: \(productID)")
            } else {
                print("Not purchased: \(productID)")
            }
            return purchased
        }
        super.init()
        SKPaymentQueue.default().add(self)
    }
}

// MARK: - StoreKit API
extension IAPManager {
    public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: productIDs)
        productsRequest!.delegate = self
        productsRequest!.start()
    }
    
    public func buyProduct(_ product: SKProduct, _ completionHandler: @escaping ProductPurchaseCompletionHandler) {
        productPurchaseCompletionHandler = completionHandler
        print("Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public func isProductPurchased(_ productID: ProductID) -> Bool {
        return purchasedProductIDs.contains(productID)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases(_ completionHandler: @escaping ProductRestoreCompletionHandler) {
        productRestoreCompletionHandler = completionHandler
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: price)!
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPManager: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Loaded list of products...")
        let products = response.products
        guard !products.isEmpty else {
            print("Product list is empty...!")
            print("Did you configure the project and set up the IAP?")
            productsRequestCompletionHandler?(false, nil)
            return
        }
        productsRequestCompletionHandler?(true, products)
        clearRequestAndHandler()
        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue) \(p.localizedPrice)")
            if p.productIdentifier == WiccaIPAProducts.unlocakWiccaYearly {
                UserDefaults.standard.set(p.price.floatValue, forKey: APP_KEYS.kUnlockWiccaPrice)
                UserDefaults.standard.set(p.localizedPrice, forKey: APP_KEYS.kUnlockWiccaLocalePrice)
            } else if p.productIdentifier == WiccaIPAProducts.unlocakWiccaLifetime {
                UserDefaults.standard.set(p.price.floatValue, forKey: APP_KEYS.kUnlockWiccaLifetimePrice)
                UserDefaults.standard.set(p.localizedPrice, forKey: APP_KEYS.kUnlockWiccaLifetimeLocalePrice)
                if #available(iOS 11.2, *) {
                    if p.introductoryPrice?.subscriptionPeriod.numberOfUnits != nil {
                        isLifetimeTrial = true
                        LifetimeTrialDays = p.introductoryPrice?.subscriptionPeriod.numberOfUnits ?? 0
                    } else {
                        isLifetimeTrial = false
                    }
                } else {
                    isLifetimeTrial = false
                }
            } else if p.productIdentifier == WiccaIPAProducts.unlocakWiccaMonthly {
                UserDefaults.standard.set(p.price.floatValue, forKey: APP_KEYS.kUnlockWiccaMonthlyPrice)
                UserDefaults.standard.set(p.localizedPrice, forKey: APP_KEYS.kUnlockWiccaMonthlyLocalePrice)
                if #available(iOS 11.2, *) {
                    if p.introductoryPrice?.subscriptionPeriod.numberOfUnits != nil {
                        isMonthlyTrial = true
                        monthlyTrialDays = p.introductoryPrice?.subscriptionPeriod.numberOfUnits ?? 0
                    } else {
                        isMonthlyTrial = false
                    }
                } else {
                    isMonthlyTrial = false
                }
            }
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver
extension IAPManager: SKPaymentTransactionObserver {
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                if (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaYearly) || (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaLifetime) || (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaMonthly) {
                    NotificationCenter.default.post(name: kCompletePurchasingPremiumPlan, object: nil, userInfo: nil)
                }
                complete(transaction: transaction)
                break
            case .failed:
                if (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaYearly) || (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaLifetime) || (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaMonthly) {
                    NotificationCenter.default.post(name: kFailPurchasingPremiumPlan, object: nil, userInfo: nil)
                }
                fail(transaction: transaction)
                break
            case .restored:
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                if (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaYearly) || (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaLifetime) || (transaction.payment.productIdentifier == WiccaIPAProducts.unlocakWiccaMonthly) {
                    NotificationCenter.default.post(name: kPurchasingPremiumPlan, object: nil, userInfo: nil)
                }
                break
            @unknown default:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        productPurchaseCompleted(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        print("restore... \(productIdentifier)")
        productRestoreCompletionHandler?(true, productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        if let transactionError = transaction.error as NSError?,
            let localizedDescription = transaction.error?.localizedDescription,
            transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }
        
        productPurchaseCompletionHandler?(false, nil)
        SKPaymentQueue.default().finishTransaction(transaction)
        clearHandler()
    }
    
    private func productPurchaseCompleted(identifier: ProductID?) {
        guard let identifier = identifier else { return }
        
        purchasedProductIDs.insert(identifier)
        UserDefaults.standard.set(true, forKey: identifier)
        productPurchaseCompletionHandler?(true, identifier)
        clearHandler()
    }
    
    private func clearHandler() {
        productPurchaseCompletionHandler = nil
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            switch prodID {
            case WiccaIPAProducts.unlocakWiccaYearly:
                // implement the given in-app purchase as if it were bought
                productPurchaseCompletionHandler?(true, prodID)
                print(prodID)
                break
            case WiccaIPAProducts.unlocakWiccaLifetime:
                // implement the given in-app purchase as if it were bought
                productPurchaseCompletionHandler?(true, prodID)
                print(prodID)
                break
            case WiccaIPAProducts.unlocakWiccaMonthly:
                // implement the given in-app purchase as if it were bought
                productPurchaseCompletionHandler?(true, prodID)
                print(prodID)
                break
            default:
                print("iap not found")
                break
            }
        }
    }
}

extension IAPManager {
    
    public func verifyReceipt(_ getEXDatecompletion: @escaping (_ expiryDate: Date) -> ()) {
        var receiptURLType: AppleReceiptValidator.VerifyReceiptURLType?
        receiptURLType = .production
        #if DEBUG
            receiptURLType = .sandbox
        #endif
        
        let appleValidator = AppleReceiptValidator(service: receiptURLType ?? .production, sharedSecret: WiccaIPAProducts.iapSharedSecrete)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            switch result {
            case .success(let receipt):
                guard let receipts_array = receipt["latest_receipt_info"] as? [Dictionary<String, Any>] else {
                    return
                }
                for receipt in receipts_array {
                    if let productID = receipt["product_id"] as? String {
                        if productID == WiccaIPAProducts.unlocakWiccaLifetime {
                            debugPrint("\(productID) is valid until \("date")\n\("items")\n")
                            StorageManager.storeIsPremiumUser(isPremium: true)
                            getEXDatecompletion(Date())
                            
                            return;
                        } else {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            formatter.timeZone = TimeZone(secondsFromGMT: 0)
                            if let strDateTime = receipt["expires_date"] as? String {
                                let strDate = strDateTime.prefix(10).trimmingCharacters(in: .whitespacesAndNewlines);
                                var date = formatter.date(from: strDate);
                                date = date?.addDays(1) ;
                                if (date == nil && (productID == WiccaIPAProducts.unlocakWiccaYearly || productID == WiccaIPAProducts.unlocakWiccaLifetime || productID == WiccaIPAProducts.unlocakWiccaMonthly)) {
                                    debugPrint("\(productID) is valid until \(date)\n\("items")\n")
                                    StorageManager.storeIsPremiumUser(isPremium: true)
                                    getEXDatecompletion(date ?? Date())
                                    
                                    return;
                                }
                                
                                if date! > Date() && (productID == WiccaIPAProducts.unlocakWiccaYearly || productID == WiccaIPAProducts.unlocakWiccaLifetime || productID == WiccaIPAProducts.unlocakWiccaMonthly) {
                                    debugPrint("\(productID) is valid until \(date)\n\("items")\n")
                                    StorageManager.storeIsPremiumUser(isPremium: true)
                                    getEXDatecompletion(date ?? Date())
                                    
                                    return
                                } else {
                                    StorageManager.storeIsPremiumUser(isPremium: false)
                                    self.showExpireReminder()
                                    debugPrint("\(productID) is expired since \(date)\n\("items")\n")
                                    UserDefaults.standard.set(true, forKey: APP_KEYS.kExpirePlan)
                                    UserDefaults.standard.set(false, forKey: APP_KEYS.kNeverPurchasePlan)
                                    
                                    return
                                }
                            } else {
                                StorageManager.storeIsPremiumUser(isPremium: false)
                                UserDefaults.standard.set(false, forKey: APP_KEYS.kNeverPurchasePlan)
                                UserDefaults.standard.set(false, forKey: APP_KEYS.kExpirePlan)
                                
                                return
                            }
                        }
                    }
                }
                
                /*var productId = [WiccaIPAProducts.unlocakWiccaMonthly, WiccaIPAProducts.unlocakWiccaYearly, WiccaIPAProducts.unlocakWiccaLifetime]
                // Verify the purchase of a Subscription
                for i in 0..<productId.count {
                    let purchaseResult = SwiftyStoreKit.verifySubscription(
                        ofType: .autoRenewable, // or .nonRenewing (see below)
                        productId: productId[i],
                        inReceipt: receipt)
                    switch purchaseResult {
                    case .purchased(let expiryDate, let items):
                        debugPrint("\(productId[i]) is valid until \(expiryDate)\n\(items)\n")
                        StorageManager.storeIsPremiumUser(isPremium: true)
                        getEXDatecompletion(expiryDate)
                        
                        //return
                    case .expired(let expiryDate, let items):
                        StorageManager.storeIsPremiumUser(isPremium: false)
                        self.showExpireReminder()
                        /*RefreshManager.shared.showExpiredReminderIfNeeded { (isNeeded) in
                         if isNeeded {
                         DispatchQueue.main.async {
                         self.showExpireReminder()
                         }
                         }
                         }*/
                        debugPrint("\(productId[i]) is expired since \(expiryDate)\n\(items)\n")
                        UserDefaults.standard.set(true, forKey: APP_KEYS.kExpirePlan)
                        UserDefaults.standard.set(false, forKey: APP_KEYS.kNeverPurchasePlan)
                    case .notPurchased:
                        debugPrint("The user has never purchased \(productId[i])")
                        UserDefaults.standard.set(true, forKey: APP_KEYS.kNeverPurchasePlan)
                        UserDefaults.standard.set(false, forKey: APP_KEYS.kExpirePlan)
                    }
                }*/
            case .error(let error):
                debugPrint("Receipt verification failed: \(error)")
                UserDefaults.standard.set(false, forKey: APP_KEYS.kNeverPurchasePlan)
                UserDefaults.standard.set(false, forKey: APP_KEYS.kExpirePlan)
            }
            NotificationCenter.default.post(name: kUpdateRestoreButtonUI, object: nil, userInfo: nil)
        }
    }
    
    public func showExpireReminder() {
        let alert = UIAlertController(title: "EXPIRED", message: "Your yearly subscription has expired. Unlock Wicca to continue access all premium features.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Unlock Wicca", style: .default, handler: { action in
            let vCnt = StoryboardScene.Main.UnlockWiccaViewController.instantiate()
            vCnt.modalPresentationStyle = .fullScreen
            AppDelegate.shared.window?.rootViewController?.present(vCnt, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Exit", style: .default, handler: { action in
            exit(0)
        }))
        AppDelegate.shared.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
/*guard let receipts_array = receipt["latest_receipt_info"] as? [Dictionary<String, Any>] else {
    return
}
if receipts_array[0]["product_id"] as! String == WiccaIPAProducts.unlocakWiccaLifetime {
    StorageManager.storeIsPremiumUser(isPremium: true)
    getEXDatecompletion(Date())
    
    return
} else {
    // Verify the purchase of a Subscription
    let purchaseResult = SwiftyStoreKit.verifySubscription(
        ofType: .autoRenewable, // or .nonRenewing (see below)
        productId: receipts_array[0]["product_id"] as! String,
        inReceipt: receipt)
    switch purchaseResult {
    case .purchased(let expiryDate, let items):
        debugPrint("\(receipts_array[0]["product_id"] as! String) is valid until \(expiryDate)\n\(items)\n")
        StorageManager.storeIsPremiumUser(isPremium: true)
        getEXDatecompletion(expiryDate)
        
        return
    case .expired(let expiryDate, let items):
        StorageManager.storeIsPremiumUser(isPremium: false)
        self.showExpireReminder()
        /*RefreshManager.shared.showExpiredReminderIfNeeded { (isNeeded) in
         if isNeeded {
         DispatchQueue.main.async {
         self.showExpireReminder()
         }
         }
         }*/
        debugPrint("\(receipts_array[0]["product_id"] as! String) is expired since \(expiryDate)\n\(items)\n")
        UserDefaults.standard.set(true, forKey: APP_KEYS.kExpirePlan)
        UserDefaults.standard.set(false, forKey: APP_KEYS.kNeverPurchasePlan)
    case .notPurchased:
        debugPrint("The user has never purchased \(receipts_array[0]["product_id"] as! String)")
        UserDefaults.standard.set(true, forKey: APP_KEYS.kNeverPurchasePlan)
        UserDefaults.standard.set(false, forKey: APP_KEYS.kExpirePlan)
    }
}*/
