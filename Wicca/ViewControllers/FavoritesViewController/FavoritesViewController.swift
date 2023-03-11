//
//  FavoritesViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 04/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoritesTableView: UITableView! {
        didSet {
            favoritesTableView.tableFooterView = UIView()
        }
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    var favourites: [FavoriteModel] = []
    var searchFavourites: [FavoriteModel] = []
    var isSearchEnable: Bool = false
    var favoriteViewModel: FavoriteViewModel = FavoriteViewModel()
    
    // MARK: Initializers
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension FavoritesViewController {
    
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
extension FavoritesViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// Register XIB
        favoritesTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    override func initialDataSetup() {
        self.favourites = favoriteViewModel.getFavorites()
        
        /// Add Observer
        let queue = OperationQueue()
        let addRemoveFavouriteSpells = Notification.Name("AddRemoveFavouriteSpells")
        NotificationCenter.default.addObserver(forName: addRemoveFavouriteSpells, object: nil, queue: queue) { _ in
            self.favourites = self.favoriteViewModel.getFavorites()
            DispatchQueue.main.async {
                if self.isSearchEnable {
                    self.searchCategoryTFEditingChanged(self.searchTextField)
                } else {
                    self.favoritesTableView.reloadData()
                }
            }
        }
    }
    
    fileprivate func fetchFavSpell(favourite: FavoriteModel) -> SpellModel {
        let spells = SubCategory.filter { (spellModel) -> Bool in
            if spellModel.spellId == favourite.favId && spellModel.spellName == favourite.favName {
                return true
            } else {
                return false
            }
        }
        return spells[0]
    }
    
    fileprivate func fetchFavHerbAndOil(favourite: FavoriteModel) -> HerbsAndOilsModel {
        let char = favourite.favName.first!
        let alphaDictionaryArr = HerbsAndOils.filter { (dictionary) -> Bool in
            if (dictionary["alphabet"] as! String).first! == char {
                return true
            } else {
                return false
            }
        }
        let herbsAndOils = (alphaDictionaryArr[0]["herbsAndOils"] as! [HerbsAndOilsModel]).filter { (herbAndOil) -> Bool in
            if herbAndOil.herbOilId == favourite.favId && herbAndOil.herbOilName == favourite.favName {
                return true
            } else {
                return false
            }
        }
        return herbsAndOils[0]
    }
    
    fileprivate func fetchFavCandleColour(favourite: FavoriteModel) -> CandleColorModel {
        let char = favourite.favName.first!
        let alphaDictionaryArr = CandleColour.filter { (dictionary) -> Bool in
            if (dictionary["alphabet"] as! String).first! == char {
                return true
            } else {
                return false
            }
        }
        let candleColoursArr = (alphaDictionaryArr[0]["diseases"] as! [CandleColorModel]).filter { (candleColour) -> Bool in
            if candleColour.diseaseId == favourite.favId && candleColour.diseaseName == favourite.favName {
                return true
            } else {
                return false
            }
        }
        return candleColoursArr[0]
    }
    
}

// MARK:- Action Perform By Selectors
extension FavoritesViewController {
    
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
            searchFavourites = favourites.filter({ (catgegory) -> Bool in
                let favName = ("\(catgegory.favName)").lowercased()
                return favName.contains(searchText)
            })
            favoritesTableView.reloadData()
        } else {
            isSearchEnable = false
            searchFavourites = []
            favoritesTableView.reloadData()
        }
    }
    
}

// MARK:- UITextFieldDelegate
extension FavoritesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        textField.resignFirstResponder()
        searchCategoryTFEditingChanged(textField)
        return true
    }
    
}

// MARK:- UITableViewDelegate, UITableViewDataSource
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchEnable == true ? searchFavourites.count : favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catCell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as? CategoryTableViewCell else { return UITableViewCell() }
        catCell.cellUseType = .Category
        let favourite = isSearchEnable == true ? searchFavourites[indexPath.row] : favourites[indexPath.row]
        catCell.categoryTitleLabel.text = favourite.favName
        return catCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentVCnt = StoryboardScene.Main.ContentViewController.instantiate()
        let favourite = isSearchEnable == true ? searchFavourites[indexPath.row] : favourites[indexPath.row]
        if favourite.favType == Purpose.Spells.rawValue {
            contentVCnt.purpose = .Spells
            contentVCnt.spell = fetchFavSpell(favourite: favourite)
        } else if favourite.favType == Purpose.HerbsAndOils.rawValue {
            contentVCnt.purpose = .HerbsAndOils
            contentVCnt.herbAndOil = fetchFavHerbAndOil(favourite: favourite)
        } else {
            contentVCnt.purpose = .CandleColors
            contentVCnt.candleColor = fetchFavCandleColour(favourite: favourite)
        }
        self.navigationController?.pushViewController(contentVCnt, animated: true)
    }
    
}

// MARK:- SideMenuDelegate
extension FavoritesViewController: SideMenuDelegate {
    
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
