//
//  HomeViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 26/01/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class HomeViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    /// NSLayoutConstraint
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    // MARK: Variables & Constants
    let menuItem: [String] = ["Spells", "Hebrs and Oils", "Calendar", "Candle Colour", "Favorites", "Lunar Calender"]
    
    // MARK: Initializers

}

// MARK:- Overided funtions (Defaults and Customs)
extension HomeViewController {
    
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
        self.view.layoutIfNeeded()
        let height = menuCollectionView.collectionViewLayout.collectionViewContentSize.height
        contentViewHeight.constant = height + 59
        self.view.layoutIfNeeded()
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
extension HomeViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// RegisterXIB
        menuCollectionView.register(UINib(nibName: "MenuItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuItemCollectionViewCell")
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension HomeViewController {
    
    @IBAction func didTapInfoButton(_ sender: UIButton) {
        let aboutVCnt = StoryboardScene.Main.AboutViewController.instantiate()
        self.navigationController?.pushViewController(aboutVCnt, animated: true)
    }
    
}

// MARK:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCollectionViewCell", for: indexPath) as? MenuItemCollectionViewCell else { return UICollectionViewCell() }
        menuCell.cellUserType = .HomeMenus
        menuCell.iconImgView.image = UIImage(named: "ic_Menu_\(indexPath.row)")
        menuCell.itemLabel.text = menuItem[indexPath.row]
        return menuCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let catVCnt = StoryboardScene.Main.SpellsCategoryViewController.instantiate()
            self.navigationController?.pushViewController(catVCnt, animated: true)
            break
        case 1:
            let herbsVCnt = StoryboardScene.Main.HerbsAndOilsViewController.instantiate()
            self.navigationController?.pushViewController(herbsVCnt, animated: true)
            break
        case 2:
            let calVCnt = StoryboardScene.Main.CalendarViewController.instantiate()
            self.navigationController?.pushViewController(calVCnt, animated: true)
        case 3:
            let canColVCnt = StoryboardScene.Main.CandleColorsViewController.instantiate()
            self.navigationController?.pushViewController(canColVCnt, animated: true)
        case 4:
            let favVCnt = StoryboardScene.Main.FavoritesViewController.instantiate()
            self.navigationController?.pushViewController(favVCnt, animated: true)
            break
        case 5:
            let lunarCalVCnt = StoryboardScene.Main.LunarCalendarViewController.instantiate()
            self.navigationController?.pushViewController(lunarCalVCnt, animated: true)
        default:
            break
        }
    }
    
    /// `UICollectionViewDelegateFlowLayout`
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 2 - 7.5
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
