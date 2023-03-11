//
//  AboutViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 25/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation
import UIKit

class AboutViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var aboutTableView: UITableView!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    
    // MARK: Initializers

}

// MARK:- Overided funtions (Defaults and Customs)
extension AboutViewController {
    
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
extension AboutViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// Register Cell
        aboutTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension AboutViewController {
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK:- Action Perform By Selectors
extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        catCell.cellUseType = .HerbsAndOils
        if indexPath.row == 0 {
            catCell.categoryTitleLabel?.text = "Privacy Policy"
        } else {
            catCell.categoryTitleLabel?.text = "Terms and Conditions"
        }
        return catCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let url = URL(string: "https://wiccaspellsapp.blogspot.com/2021/02/privacy-policy-this-page-informs-you-of.html") {
                UIApplication.shared.open(url)
            }
        } else {
            if let url = URL(string: "https://wiccaspellsapp.blogspot.com/2021/02/terms-and-conditions.html") {
                UIApplication.shared.open(url)
            }
        }
    }
    
}
