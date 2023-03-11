//
//  SideMenuViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 27/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

protocol SideMenuDelegate {
    func didTapMenuItem(menuItem: String)
}

class SideMenuViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var sideMenuTableView: UITableView! {
        didSet {
            sideMenuTableView.tableFooterView = UIView()
        }
    }
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    let transition:CATransition = {
        let this = CATransition()
        this.duration = 0.5
        this.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        this.type = CATransitionType.push
        this.subtype = CATransitionSubtype.fromRight
        return this
    }()
    
    var delegate: SideMenuDelegate?
    let menuItemsICs: [UIImage] = [#imageLiteral(resourceName: "ic_Spellsbook"), #imageLiteral(resourceName: "ic_Fav")]
    let menuItems: [String] = ["Spellbook", "Favorite Spells"]
    
    // MARK: Initializers

}

// MARK:- Overided funtions (Defaults and Customs)
extension SideMenuViewController {
    
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
        let transition:CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.layer.add(transition, forKey: kCATransition)
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
extension SideMenuViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// Register XIB
        sideMenuTableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuTableViewCell")
        
        /// Register Gesture
        let tapGest = UITapGestureRecognizer.init(target: self, action: #selector(didTapBackgroundView(_:)))
        backgroundView.addGestureRecognizer(tapGest)
        
        self.view.layer.add(transition, forKey: kCATransition)
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension SideMenuViewController {
    
    @objc func didTapBackgroundView(_ sender: UITapGestureRecognizer) {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
    }
    
}

// MARK:- Action Perform By Selectors
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuItemCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuTableViewCell", for: indexPath) as? SideMenuTableViewCell else { return UITableViewCell() }
        menuItemCell.menuItemICImageView.image = menuItemsICs[indexPath.row]
        menuItemCell.menuItemLabel.text = menuItems[indexPath.row]
        return menuItemCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.dismiss(animated: false) {
                self.delegate?.didTapMenuItem(menuItem: self.menuItems[indexPath.row])
            }
        }
    }
    
}
