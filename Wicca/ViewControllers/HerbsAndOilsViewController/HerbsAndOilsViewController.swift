//
//  HerbsAndOilsViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 02/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class HerbsAndOilsViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var herbsAndOilsTableView: UITableView! {
        didSet {
            herbsAndOilsTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    lazy var headerView: HerbsAndOilsHeader = {
        let this = Bundle.main.loadNibNamed("HerbsAndOilsHeader", owner: self, options: nil)?.first as? HerbsAndOilsHeader
        return this ?? HerbsAndOilsHeader()
    }()
    
    // MARK: Initializers
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension HerbsAndOilsViewController {
    
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
extension HerbsAndOilsViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        titleLabel.text = "Herbs and Oils"
        /// Register XIB
        herbsAndOilsTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension HerbsAndOilsViewController {
    
    @IBAction func didTapMenuButton(_ sender: UIButton) {
        let sideMenuVCnt = StoryboardScene.Main.SideMenuViewController.instantiate()
        sideMenuVCnt.modalPresentationStyle = .overCurrentContext
        sideMenuVCnt.delegate = self
        self.present(sideMenuVCnt, animated: false, completion: nil)
    }
    
    @IBAction func didTapHomeButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension HerbsAndOilsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HerbsAndOils.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (HerbsAndOils[section]["herbsAndOils"] as! [HerbsAndOilsModel]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        catCell.cellUseType = .HerbsAndOils
        let herbsAndOils = HerbsAndOils[indexPath.section]["herbsAndOils"] as! [HerbsAndOilsModel]
        catCell.categoryTitleLabel?.text = herbsAndOils[indexPath.row].herbOilName
        return catCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let this = Bundle.main.loadNibNamed("HerbsAndOilsHeader", owner: self, options: nil)?.first as? HerbsAndOilsHeader
        let alphabet = HerbsAndOils[section]["alphabet"] as! String
        this?.alphabetLabel.text = alphabet
        return this ?? HerbsAndOilsHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// `In-App Purchase`
        if !StorageManager.isPremiumUser {
            let vCnt = StoryboardScene.Main.UnlockWiccaViewController.instantiate()
            vCnt.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vCnt, animated: true, completion: nil)
            }
        } else {
            let contentVCnt = StoryboardScene.Main.ContentViewController.instantiate()
            contentVCnt.purpose = .HerbsAndOils
            let herbsAndOils = HerbsAndOils[indexPath.section]["herbsAndOils"] as! [HerbsAndOilsModel]
            contentVCnt.herbAndOil = herbsAndOils[indexPath.row]
            self.navigationController?.pushViewController(contentVCnt, animated: true)
        }
    }
    
}

// MARK:- SideMenuDelegate
extension HerbsAndOilsViewController: SideMenuDelegate {
    
    func didTapMenuItem(menuItem: String) {
        switch menuItem {
        case "Spellbook":
            if (UIApplication.getTopViewController() as? CategoryViewController) == nil {
                let vCnt = StoryboardScene.Main.SpellsCategoryViewController.instantiate()
                self.navigationController?.pushViewController(vCnt, animated: true)
            }
            break
        case "Favorite Spells":
            if (UIApplication.getTopViewController() as? FavoritesViewController) == nil {
                let vCnt = StoryboardScene.Main.FavoritesViewController.instantiate()
                self.navigationController?.pushViewController(vCnt, animated: true)
            }
            break
        default:
            break
        }
    }
    
}
