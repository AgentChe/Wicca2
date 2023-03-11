//
//  CalendarViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 03/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class CalenderViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var monthsCollectionView: UICollectionView!
    
    /// NSLayoutConstraint
    @IBOutlet weak var collViewtViewHeight: NSLayoutConstraint!
    
    // MARK: Variables & Constants
    let monthsArr: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension CalenderViewController {
    
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
        let height = monthsCollectionView.collectionViewLayout.collectionViewContentSize.height
        collViewtViewHeight.constant = height
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
extension CalenderViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        /// RegisterXIB
        monthsCollectionView.register(UINib(nibName: "MenuItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MenuItemCollectionViewCell")
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension CalenderViewController {
    
    // MARK: Initializers
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

// MARK:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CalenderViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let menuCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCollectionViewCell", for: indexPath) as? MenuItemCollectionViewCell else { return UICollectionViewCell() }
        menuCell.cellUserType = .CalenderMonths
        menuCell.iconImgView.image = UIImage(named: "month_\(indexPath.row+1)")
        return menuCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /// `In-App Purchase`
        if indexPath.row > 1 && !StorageManager.isPremiumUser {
            let vCnt = StoryboardScene.Main.UnlockWiccaViewController.instantiate()
            vCnt.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vCnt, animated: true, completion: nil)
            }
        } else {
            let contentVCnt = StoryboardScene.Main.ContentViewController.instantiate()
            contentVCnt.purpose = .Calendar
            contentVCnt.calendarEvent = Calender[indexPath.row]
            self.navigationController?.pushViewController(contentVCnt, animated: true)
        }
    }
    
    /// `UICollectionViewDelegateFlowLayout`
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 3 - 6
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

// MARK:- SideMenuDelegate
extension CalenderViewController: SideMenuDelegate {
    
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
