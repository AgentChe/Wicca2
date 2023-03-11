//
//  UnlockWiccaViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 09/04/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class UnlockWiccaViewController: BaseVc {

    // MARK: Outlet
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            tableView.tableFooterView = UIView()
//        }
//    }
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var lifetimeContinueButton: UIButton!
    @IBOutlet weak var alreadyMemberButton: UIButton!
    @IBOutlet weak var TAndCButton: UIButton!
    @IBOutlet weak var privacyButton: UIButton!
    
    // @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    
    var purchaseId = "com.bigideaapps.Wikka.inapp.lifeline"
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    var btnContinue: UIButton = UIButton()
    var btnRestore: UIButton = UIButton()
    var products: [SKProduct] = []
    
    // MARK: Initializers
    
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension UnlockWiccaViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialUISetup()
        initialDataSetup()
        
        self.continueButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.continueButton.titleLabel?.numberOfLines = 1
        self.continueButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.continueButton.titleLabel?.textAlignment = .center
        self.lifetimeContinueButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.lifetimeContinueButton.titleLabel?.numberOfLines = 2
        self.lifetimeContinueButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.lifetimeContinueButton.titleLabel?.textAlignment = .center
        
        self.lifetimeContinueButton.setTitle("\(StorageManager.unlocakWiccaLifetimeLocalePrice)/once. Lifetime Access.\nBest Value", for: .normal)
        if isMonthlyTrial == true {
            self.priceLabel.text = "\(StorageManager.unlocakWiccaLifetimeLocalePrice) one-time purchase for Lifetime access or \(monthlyTrialDays) days free and \(StorageManager.unlocakWiccaMonthlyLocalePrice) per month"
            self.continueButton.setTitle("\(monthlyTrialDays) days free then \(StorageManager.unlocakWiccaMonthlyLocalePrice)/month", for: .normal)
        } else {
            self.priceLabel.text = "\(StorageManager.unlocakWiccaLifetimeLocalePrice) one-time purchase for Lifetime access or 3 days free and \(StorageManager.unlocakWiccaMonthlyLocalePrice) per month"
            self.continueButton.setTitle("3 days free then \(StorageManager.unlocakWiccaMonthlyLocalePrice)/month", for: .normal)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}

// MARK:- Custom Funtions
extension UnlockWiccaViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// SetupUI
        if UIScreen.main.bounds.height <= 568.0 {
//            priceLabel.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 17)
//            continueButton.titleLabel?.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 17)
//            alreadyMemberButton.titleLabel?.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 17)
            TAndCButton.titleLabel?.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 17)
            privacyButton.titleLabel?.font = UIFont.init(type: .PlayfairDisplay_Regular, size: 17)
        }
        
        /// Register CellXIB
        //tableView.register(UINib(nibName: "WiccaLogoTableViewCell", bundle: nil), forCellReuseIdentifier: "WiccaLogoTableViewCell")
        //tableView.register(UINib(nibName: "FeaturesTableViewCell", bundle: nil), forCellReuseIdentifier: "FeaturesTableViewCell")
        //tableView.register(UINib(nibName: "PurchaseTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseTableViewCell")
        
        let queue = OperationQueue()
        NotificationCenter.default.addObserver(forName: kPurchasingPremiumPlan, object: nil, queue: queue) { _ in
            DispatchQueue.main.async {
                self.btnContinue.alpha = CGFloat(1)
                self.btnContinue.isEnabled = true
                self.btnRestore.alpha = CGFloat(1)
                self.btnRestore.isEnabled = true
                self.showLoader()
            }
        }
        NotificationCenter.default.addObserver(forName: kFailPurchasingPremiumPlan, object: nil, queue: queue) { _ in
            DispatchQueue.main.async {
                self.btnContinue.alpha = CGFloat(1)
                self.btnContinue.isEnabled = true
                self.btnRestore.alpha = CGFloat(1)
                self.btnRestore.isEnabled = true
                self.dismissLoader()
            }
        }
        NotificationCenter.default.addObserver(forName: kCompletePurchasingPremiumPlan, object: nil, queue: queue) { _ in
            /*DispatchQueue.main.async {
                self.btnContinue.alpha = CGFloat(1)
                self.btnContinue.isEnabled = true
                self.btnRestore.alpha = CGFloat(1)
                self.btnRestore.isEnabled = true
                self.activityIndicator.stopAnimating()
            }*/
        }
        
        NotificationCenter.default.addObserver(forName: kUpdateRestoreButtonUI, object: nil, queue: queue) { _ in
            DispatchQueue.main.async {
                if (UserDefaults.standard.bool(forKey: APP_KEYS.kNeverPurchasePlan) || UserDefaults.standard.bool(forKey: APP_KEYS.kExpirePlan)) {
                    self.btnRestore.isEnabled = false
                    self.btnRestore.alpha = CGFloat(0.50)
                } else {
                    self.btnRestore.isEnabled = true
                    self.btnRestore.alpha = CGFloat(1)
                }
            }
        }
        
        if (UserDefaults.standard.bool(forKey: APP_KEYS.kNeverPurchasePlan) || UserDefaults.standard.bool(forKey: APP_KEYS.kExpirePlan)) {
            btnRestore.isEnabled = false
            btnRestore.alpha = CGFloat(0.50)
        } else {
            btnRestore.isEnabled = true
            btnRestore.alpha = CGFloat(1)
        }
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension UnlockWiccaViewController {
    
    @IBAction func didTapDismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapLifetimeContinueButton(_ sender: UIButton) {
        self.showLoader()
        print("price - \(StorageManager.unlocakWiccaLocalePrice)")
        print("price - \(StorageManager.unlocakWiccaLifetimeLocalePrice)")
        print("price - \(StorageManager.unlocakWiccaMonthlyLocalePrice)")
        WiccaIPAProducts.store.requestProducts { [weak self] success, products in
            guard let self = self else { return }
            guard success else {
                self.dismissLoader()
                return
            }
            self.products = products!
            
            if UserDefaults.standard.bool(forKey: WiccaIPAProducts.unlocakWiccaLifetime) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "You have already purchased this plan previously.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                        StorageManager.storeIsPremiumUser(isPremium: true)
                        self.dismissLoader()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    debugPrint("Continue button tapped")
                    self.purchaseId = "com.bigideaapps.Wikka.inapp.lifeline"
                    self.onContinueBtn(products: self.products)
                }
            }
        }
    }
    
    @IBAction func didTapContinueButton(_ sender: UIButton) {
        self.showLoader()
        WiccaIPAProducts.store.requestProducts { [weak self] success, products in
            guard let self = self else { return }
            guard success else {
               /*DispatchQueue.main.async {
                   let alertController = UIAlertController(title: "Failed to load list of products",
                                                           message: "Check logs for details",
                                                           preferredStyle: .alert)
                   alertController.addAction(UIAlertAction(title: "OK", style: .default))
                   self.present(alertController, animated: true, completion: nil)
               }*/
                self.dismissLoader()
                return
            }
            self.products = products!
            
            if UserDefaults.standard.bool(forKey: WiccaIPAProducts.unlocakWiccaMonthly) {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "You have already purchased this plan previously.", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                        StorageManager.storeIsPremiumUser(isPremium: true)
                        self.dismissLoader()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    debugPrint("Continue button tapped")
                    self.purchaseId = "com.bigideaapps.Wikka.inapp.subscription.monthly"
                    self.onContinueBtn(products: self.products)
                }
            }
        }
    }
    
    @IBAction func didTapAlreadyMemberButton(_ sender: UIButton) {
        self.showLoader()
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            self.dismissLoader()
//            if results.restoreFailedPurchases.count == 0 {
//                debugPrint("Nothing to Restore \(results.restoreFailedPurchases)")
//                if (UserDefaults.standard.bool(forKey: APP_KEYS.kNeverPurchasePlan) && !UserDefaults.standard.bool(forKey: APP_KEYS.kExpirePlan)) {
//                    let alert = UIAlertController(title: "You have not unlocked Wicca.", message: "", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                        StorageManager.storeIsPremiumUser(isPremium: false)
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                } else if (!UserDefaults.standard.bool(forKey: APP_KEYS.kNeverPurchasePlan) && UserDefaults.standard.bool(forKey: APP_KEYS.kExpirePlan)) {
//                    let alert = UIAlertController(title: "You have ended your premium features.", message: "", preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//                        StorageManager.storeIsPremiumUser(isPremium: false)
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                }
            //} else
        if results.restoredPurchases.count > 0 {
                debugPrint("Restore Success: \(results.restoredPurchases)")
                DispatchQueue.main.async {
                    if (results.restoredPurchases[0].productId == WiccaIPAProducts.unlocakWiccaYearly) || (results.restoredPurchases[0].productId == WiccaIPAProducts.unlocakWiccaLifetime) || (results.restoredPurchases[0].productId == WiccaIPAProducts.unlocakWiccaMonthly) {
                        WiccaIPAProducts.store.verifyReceipt { (expiryDate) in
                            // let strExDate = DateFormat.yyyy_MM_dd_HH_MM_SS.formatter.string(from: expiryDate)
                            // let utcEXDate = UTCToLocal(date: strExDate, dateFormat: DateFormat.yyyy_MM_dd_HH_MM_SS.rawValue)
                            let alert = UIAlertController(title: "Successfully restored app", message: "", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                                self.dismiss(animated: true, completion: nil)
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "You have not unlocked Wicca.", message: "", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            StorageManager.storeIsPremiumUser(isPremium: false)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                debugPrint("Restore Failed.")
                let alert = UIAlertController(title: "Restore Failed.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { action in
                    StorageManager.storeIsPremiumUser(isPremium: false)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func didTapOnTAndCButton(_ sender: UIButton) {
        if let url = URL(string: "https://wiccaspellsapp.blogspot.com/2021/02/terms-and-conditions.html") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func didTapOnPrivacyButton(_ sender: UIButton) {
        if let url = URL(string: "https://wiccaspellsapp.blogspot.com/2021/02/privacy-policy-this-page-informs-you-of.html") {
            UIApplication.shared.open(url)
        }
    }
    
}

// MARK:- Action Perform By Selectors
/*extension UnlockWiccaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WiccaLogoTableViewCell", for: indexPath) as? WiccaLogoTableViewCell else { return UITableViewCell() }
            return cell
        } else /*if indexPath.row == 1*/ {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeaturesTableViewCell", for: indexPath) as? FeaturesTableViewCell else { return UITableViewCell() }
            cell.priceLbl.text = "\(StorageManager.unlocakWiccaLifetimeLocalePrice) one-time purchase for Lifetime access or \(monthlyTrialDays) days free and \(StorageManager.unlocakWiccaMonthlyLocalePrice) per month"
            
            return cell
        } /*else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PurchaseTableViewCell", for: indexPath) as? PurchaseTableViewCell else { return UITableViewCell() }
            cell.continueButton.addTarget(self, action: #selector(didTapContinueButton(_:)), for: .touchUpInside)
            cell.alreadyMemberButton.addTarget(self, action: #selector(didTapAlreadyMemberButton(_:)), for: .touchUpInside)
            self.btnContinue = cell.continueButton
            self.btnRestore = cell.alreadyMemberButton
            return cell
        }*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
}*/

extension UnlockWiccaViewController {
    
    func onContinueBtn(products: [SKProduct]) {
        guard !products.isEmpty else {
            print("Cannot purchase subscription because products is empty!")
            return
        }
        if (products[0].productIdentifier == WiccaIPAProducts.unlocakWiccaYearly) || (products[0].productIdentifier == WiccaIPAProducts.unlocakWiccaLifetime) || (products[0].productIdentifier == WiccaIPAProducts.unlocakWiccaMonthly) {
            if self.purchaseId == "com.bigideaapps.Wikka.inapp.subscription.monthly" {
                if products[0].productIdentifier == self.purchaseId {
                    self.purchaseItem(product: products[0])
                } else if products[1].productIdentifier == self.purchaseId {
                    self.purchaseItem(product: products[1])
                } else {
                    self.purchaseItem(product: products[2])
                }
            } else if self.purchaseId == "com.bigideaapps.Wikka.inapp.lifeline" {
                if products[0].productIdentifier == self.purchaseId {
                    self.purchaseItem(product: products[0])
                } else if products[1].productIdentifier == self.purchaseId {
                    self.purchaseItem(product: products[1])
                } else {
                    self.purchaseItem(product: products[2])
                }
            }
        }
    }
    
    private func purchaseItem(product: SKProduct) {
        WiccaIPAProducts.store.buyProduct(product) { [weak self] success, productId in
            guard let self = self else { return }
            guard success else {
                let alertController = UIAlertController(title: "Failed to purchase product",
                                                        message: "Check logs for details",
                                                        preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alertController, animated: true, completion: nil)
                // AppDelegate.shared.window?.rootViewController?.dismiss(animated: true, completion: nil)
                return
            }
            if (productId == WiccaIPAProducts.unlocakWiccaYearly) || (productId == WiccaIPAProducts.unlocakWiccaLifetime) || (productId == WiccaIPAProducts.unlocakWiccaMonthly) {
                WiccaIPAProducts.store.verifyReceipt { (expiryDate) in
                    // let strExDate = DateFormat.yyyy_MM_dd_HH_MM_SS.formatter.string(from: expiryDate)
                    // let utcEXDate = UTCToLocal(date: strExDate, dateFormat: DateFormat.yyyy_MM_dd_HH_MM_SS.rawValue)
                    self.dismissLoader()
                    let alert = UIAlertController(title: "Successfully unlocked all features", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
}
