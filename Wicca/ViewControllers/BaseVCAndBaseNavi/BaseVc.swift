import Foundation
import UIKit

class BaseVc: UIViewController {
   
    //************************************************
    // MARK: Variables & Constants
    //************************************************
    
    /// Helpers
    
    /// Helps to nide nav bar
    var hideNavigationBarForSelf : Bool? = nil
    
    /// Helps to hide status bar
    private var _hideStatusBar : Bool = false
    var hideStatusBar : Bool {
        set {
            _hideStatusBar = newValue
            self.setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _hideStatusBar
        }
    }
    
    /// Helps to enable swipe on back, even if use custom back button
    @objc dynamic var enableSwipeToGoBack : Bool {
        return true
    }
    
    /// Custom completion hanlders
    var willDismissHandler : (() -> ())? = nil
    var didDismissHandler : (() -> ())? = nil
    
    //************************************************
    // MARK: Defaults
    //************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        if enableSwipeToGoBack {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupHeader()
        if self.hideNavigationBarForSelf == true {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.hideNavigationBarForSelf == true {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    @objc dynamic func setupHeader() {
        
    }
    
    @objc dynamic func initialUISetup() {
        
    }
    
    @objc dynamic func initialDataSetup() {
        
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: {
            self.didDismissHandler?()
            completion?()
        })
        self.willDismissHandler?()
    }
    
    /**
     Status bar management
     */
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return _hideStatusBar
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
}

//************************************************************************************************
// MARK: UIGestureRecognizerDelegate (Helps to manage swipe back func..)
//************************************************************************************************

extension BaseVc : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

