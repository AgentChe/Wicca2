//
//  LunarMoonPhasesViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 23/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class LunarMoonPhasesViewController: BaseVc {

    // MARK: Outlet
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    
    // MARK: Initializers

}

// MARK:- Overided funtions (Defaults and Customs)
extension LunarMoonPhasesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetup()
        initialDataSetup()
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
extension LunarMoonPhasesViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension LunarMoonPhasesViewController {
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

