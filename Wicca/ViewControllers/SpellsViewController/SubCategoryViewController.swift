//
//  SpellsViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 27/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class SubCategoryViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subCategoryTableView: UITableView! {
        didSet {
            subCategoryTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    var spellCategoryId: Int = 0
    var spellCategoryName: String = ""
    var spellsArr: [SpellModel] = []
    var searchSpellsArr: [SpellModel] = []
    var isSearchEnable: Bool = false
    var purpose: Purpose = .Spells
    
    // MARK: Initializers
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension SubCategoryViewController {
    
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
extension SubCategoryViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        titleLabel.text = spellCategoryName
        /// Register XIB
        subCategoryTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func initialDataSetup() {
        // subCategoryViewModel.storeSubCategories()
        // self.subCategoryArr = subCategoryViewModel.getSubCategories()
        self.spellsArr = SubCategory.filter({ (subCat) -> Bool in
            if subCat.categoryId == self.spellCategoryId {
                return true
            } else {
                return false
            }
        })
    }
    
}

// MARK:- UITextFieldDelegate
extension SubCategoryViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        searchSubCategoryTFEditingChanged(textField)
        return true
    }
    
}

// MARK:- Action Perform By Selectors
extension SubCategoryViewController {

    @IBAction func didTapMenuButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchSubCategoryTFEditingChanged(_ sender: UITextField) {
        let searchText = sender.text!.lowercased()
        if searchText != "" {
            isSearchEnable = true
            searchSpellsArr = spellsArr.filter({ (catgegory) -> Bool in
                let categoryName = ("\(catgegory.spellName)").lowercased()
                return categoryName.contains(searchText)
            })
            subCategoryTableView.reloadData()
        } else {
            isSearchEnable = false
            searchSpellsArr = []
            subCategoryTableView.reloadData()
        }
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension SubCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchEnable == true ? searchSpellsArr.count : spellsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        let spell = isSearchEnable == true ? searchSpellsArr[indexPath.row] : spellsArr[indexPath.row]
        catCell.categoryTitleLabel?.text = spell.spellName
        return catCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentVCnt = StoryboardScene.Main.ContentViewController.instantiate()
        contentVCnt.purpose = purpose
        let spell = isSearchEnable == true ? searchSpellsArr[indexPath.row] : spellsArr[indexPath.row]
        contentVCnt.spell = spell
        self.navigationController?.pushViewController(contentVCnt, animated: true)
    }
    
}
