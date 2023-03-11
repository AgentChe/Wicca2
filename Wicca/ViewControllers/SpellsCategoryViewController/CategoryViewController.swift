//
//  SpellsCategoryViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 27/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class CategoryViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryTableView: UITableView! {
        didSet {
            categoryTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    var searchSpellsCategory: [SpellCategoryModel] = []
    var isSearchEnable: Bool = false
    
    // MARK: Initializers
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension CategoryViewController {
    
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
extension CategoryViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// Register XIB
        categoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func initialDataSetup() {
        /*debugPrint(Realm.Configuration.defaultConfiguration.fileURL ?? "")
        if spellsCategoryViewModel.getCategories().isEmpty {
            self.spellsCategoryViewModel.storeCategories()
        }
        self.spellsCategoryArr = spellsCategoryViewModel.getCategories()*/
    }
    
}

// MARK:- UITextFieldDelegate
extension CategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        searchCategoryTFEditingChanged(textField)
        return true
    }
    
}

// MARK:- Action Perform By Selectors
extension CategoryViewController {
    
    @IBAction func didTapMenuButton(_ sender: UIButton) {
        let sideMenuVCnt = StoryboardScene.Main.SideMenuViewController.instantiate()
        sideMenuVCnt.modalPresentationStyle = .overCurrentContext
        sideMenuVCnt.delegate = self
        self.present(sideMenuVCnt, animated: false, completion: nil)
    }
    
    @IBAction func didTapHomeButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func searchCategoryTFEditingChanged(_ sender: UITextField) {
        let searchText = sender.text!.lowercased()
        if searchText != "" {
            isSearchEnable = true
            searchSpellsCategory = SpellsCategory.filter({ (catgegory) -> Bool in
                let categoryName = ("\(catgegory.categoryName)").lowercased()
                return categoryName.contains(searchText)
            })
            categoryTableView.reloadData()
        } else {
            isSearchEnable = false
            searchSpellsCategory = []
            categoryTableView.reloadData()
        }
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchEnable == true ? searchSpellsCategory.count : SpellsCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        catCell.cellUseType = .Category
        let category = isSearchEnable == true ? searchSpellsCategory[indexPath.row] : SpellsCategory[indexPath.row]
        catCell.categoryTitleLabel?.text = category.categoryName
        return catCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spellsVCnt = StoryboardScene.Main.SpellsViewController.instantiate()
        spellsVCnt.purpose = .Spells
        let category = isSearchEnable == true ? searchSpellsCategory[indexPath.row] : SpellsCategory[indexPath.row]
        /// `In-App Purchase`
        if category.categoryId > 2 && !StorageManager.isPremiumUser {
            let vCnt = StoryboardScene.Main.UnlockWiccaViewController.instantiate()
            vCnt.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vCnt, animated: true, completion: nil)
            }
        } else {
            spellsVCnt.spellCategoryId = category.categoryId
            spellsVCnt.spellCategoryName = category.categoryName
            self.navigationController?.pushViewController(spellsVCnt, animated: true)
        }
    }
    
}

// MARK:- SideMenuDelegate
extension CategoryViewController: SideMenuDelegate {
    
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
