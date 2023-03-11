//
//  LunarCalenderViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 03/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class LunarCalenderViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lunarCalTableView: UITableView! {
        didSet {
            lunarCalTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    
    // MARK: Initializers
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension LunarCalenderViewController {
    
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
extension LunarCalenderViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// Register XIB
        lunarCalTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func initialDataSetup() {
        // categoryViewModel.storeCategories()
        // self.categoryArr = categoryViewModel.getCategories()
    }
    
}

// MARK:- Action Perform By Selectors
extension LunarCalenderViewController {
    
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
extension LunarCalenderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LunarCalener.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        if indexPath.row == 0 {
            catCell.cellUseType = .Category
            catCell.categoryTitleLabel?.text = "Calender"
        } else {
            catCell.cellUseType = .LunarCalender
            let attr = AttributedStringBuilder.init()
            attr.text(LunarCalener[indexPath.row - 1].lunarName,
                      attributes: [.textColor(UIColor.white),
                                   .font(UIFont.init(type: .PlayfairDisplay_Regular, size: 25)!)])
                .text("  \(LunarCalener[indexPath.row - 1].lunarDate)",
                    attributes: [.textColor(UIColor.white),
                                 .font(UIFont.init(type: .PlayfairDisplay_Regular, size: 17)!)])
            catCell.categoryTitleLabel?.attributedText = attr.attributedString
        }
        return catCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let calVCnt = StoryboardScene.Main.CalendarViewController.instantiate()
            self.navigationController?.pushViewController(calVCnt, animated: true)
        }
    }
    
}

// MARK:- SideMenuDelegate
extension LunarCalenderViewController: SideMenuDelegate {
    
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
