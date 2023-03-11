import Foundation
import UIKit

class BaseNavi: UINavigationController {
    
    //************************************************
    // MARK: Defaults
    //************************************************
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.shouldRemoveShadow(true)
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
    
    //************************************************
    // MARK: Outlets
    //************************************************
    
    /// Datasource Related
    
    /// Helpers
    
    //************************************************
    // MARK: Variables
    //************************************************
    
    /// Helpers
    
    /// Datasource Related
    
    /// UI Related
}


//************************************************
// MARK: Actions
//************************************************

extension BaseNavi
{
    /// Funtions Executed via Selector's
    
    /// @IBActions
}


//************************************************
// MARK: Custom Funtions
//************************************************

extension BaseNavi
{
    
}

//************************************************
// MARK: Navigation bar Extension
//************************************************

extension UINavigationBar {
    
    func shouldRemoveShadow(_ value: Bool) -> Void {
        if value {
            self.setValue(true, forKey: "hidesShadow")
        } else {
            self.setValue(false, forKey: "hidesShadow")
        }
    }
}
