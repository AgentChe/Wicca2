//
//  UIKitExtension.swift
//  Wicca
//
//  Created by Jay Jariwala on 26/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import SVProgressHUD

extension UIButton {
    @IBInspectable public var Localize: Bool {
        get { return false }
        set { if (newValue) {
            setTitle( title(for:.normal)?.localize,      for:.normal)
            setTitle( title(for:.highlighted)?.localize, for:.highlighted)
            setTitle( title(for:.selected)?.localize,    for:.selected)
            setTitle( title(for:.disabled)?.localize,    for:.disabled)
        }}
    }
}

extension UITabBarItem {
    @IBInspectable public var Localize: Bool {
        get { return false }
        set { if (newValue) { title = title?.localize }}
    }
}

extension UITextField {
    @IBInspectable public var Localize: Bool {
        get { return false }
        set { if (newValue) {
            placeholder = placeholder?.localize
            text = text?.localize
        }}
    }
    
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        switch padding {
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = equalPaddingView
            self.leftViewMode = .always
            // right
            self.rightView = equalPaddingView
            self.rightViewMode = .always
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentWithFadeAnimation(viewControllerToPresent vc: UIViewController, completion: (() -> Void)?) {
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: completion)
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.setDefaultStyle(.light)
            SVProgressHUD.setDefaultMaskType(.clear)
            SVProgressHUD.show()
        }
    }
    
    func dismissLoader() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
    
}

extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}

extension AVPlayerItem {
    var url: URL? {
        return (asset as? AVURLAsset)?.url
    }
}

extension UIDevice {
    var iPhoneX: Bool { UIScreen.main.nativeBounds.height == 2436 }
    var iPhone: Bool { UIDevice.current.userInterfaceIdiom == .phone }
    var iPad: Bool { UIDevice().userInterfaceIdiom == .pad }
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR_11 = "iPhone XR or iPhone 11"
        case iPhone_XSMax_ProMax = "iPhone XS Max or iPhone Pro Max"
        case iPhone_11Pro = "iPhone 11 Pro"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR_11
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2426:
            return .iPhone_11Pro
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax_ProMax
        default:
            return .unknown
        }
    }

}

extension UIApplication {
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
