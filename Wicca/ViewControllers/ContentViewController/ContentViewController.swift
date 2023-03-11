//
//  ContentViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 04/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import UIKit

class ContentViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleNameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var decreaseFontButton: UIButton!
    @IBOutlet weak var increaseFontButton: UIButton!
    @IBOutlet weak var stackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var notesView: UIView!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    var favoriteViewModel: FavoriteViewModel = FavoriteViewModel()
    var spell: SpellModel!
    var herbAndOil: HerbsAndOilsModel!
    var calendarEvent: CalendarEventModel!
    var candleColor: CandleColorModel!
    var lunarCalendar: LunarCalenderModel!
    var currentFontSize: Int = 18
    var purpose: Purpose = .Spells
    var favouriteModel: FavoriteModel = FavoriteModel()
    
    // MARK: Initializers
    
}

// MARK:- Overided funtions (Defaults and Customs)
extension ContentViewController {
    
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
extension ContentViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        switch purpose {
        case .Spells:
            favouriteModel = FavoriteModel(favId: spell.spellId, favName: spell.spellName, content: spell.spellContent, favType: purpose.rawValue)
            if favoriteViewModel.isFavorite(favorite: favouriteModel) {
                favoriteButton.setImage(UIImage(named: "ic_favorite"), for: .normal)
                favoriteButton.isSelected = true
            }
            titleNameLabel.text = spell.spellName
            contentTextView.text = spell.spellContent
            break
        case .HerbsAndOils:
            removeNotesFeature()
            favouriteModel = FavoriteModel(favId: herbAndOil.herbOilId, favName: herbAndOil.herbOilName, content: herbAndOil.ingredients, favType: purpose.rawValue)
            if favoriteViewModel.isFavorite(favorite: favouriteModel) {
                favoriteButton.setImage(UIImage(named: "ic_favorite"), for: .normal)
                favoriteButton.isSelected = true
            }
            titleNameLabel.text = herbAndOil.herbOilName
            contentTextView.text = herbAndOil.ingredients
            break
        case .Calendar:
            removeFavAndNoteFeature()
            titleNameLabel.text = calendarEvent.monthName
            contentTextView.text = calendarEvent.event
            break
        case .CandleColors:
            removeNotesFeature()
            favouriteModel = FavoriteModel(favId: candleColor.diseaseId, favName: candleColor.diseaseName, content: candleColor.candleColor, favType: purpose.rawValue)
            if favoriteViewModel.isFavorite(favorite: favouriteModel) {
                favoriteButton.setImage(UIImage(named: "ic_favorite"), for: .normal)
                favoriteButton.isSelected = true
            }
            titleNameLabel.text = candleColor.diseaseName
            contentTextView.text = candleColor.candleColor
            break
        case .LunarCalendar:
            removeFavAndNoteFeature()
            titleNameLabel.text = "\(lunarCalendar.lunarName) \(lunarCalendar.lunarDate)"
            contentTextView.text = lunarCalendar.signDesc
            break
        }
    }
    
    override func initialDataSetup() {
        
    }
    
    func enableButton(caller: UIButton) {
        caller.alpha = CGFloat(1)
        caller.isEnabled = true
    }
    
    func disableButton(caller: UIButton) {
        caller.alpha = CGFloat(0.5)
        caller.isEnabled = false
    }
    
    func removeNotesFeature() {
        notesView.removeFromSuperview()
        stackViewWidth.constant = CGFloat(121)
    }
    
    func removeFavAndNoteFeature() {
        favoriteButton.removeFromSuperview()
        notesView.removeFromSuperview()
        stackViewWidth.constant = CGFloat(78)
    }
    
}

// MARK:- Action Perform By Selectors
extension ContentViewController {
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        if favoriteButton.isSelected {
            sender.setImage(UIImage(named: "ic_un_favorite"), for: .normal)
            favoriteButton.isSelected = false
            favoriteViewModel.removeFavorite(favorite: favouriteModel)
        } else {
            sender.setImage(UIImage(named: "ic_favorite"), for: .normal)
            favoriteButton.isSelected = true
            favoriteViewModel.addFavorite(favorite: favouriteModel)
        }
        NotificationCenter.default.post(name: Notification.Name("AddRemoveFavouriteSpells"), object: nil)
    }
    
    @IBAction func didTapIncreaseFontButton(_ sender: UIButton) {
        currentFontSize += 2
        if currentFontSize == 24 {
            self.disableButton(caller: self.increaseFontButton)
        } else {
            self.enableButton(caller: self.increaseFontButton)
        }
        if currentFontSize > 14 {
            self.enableButton(caller: self.decreaseFontButton)
        }
        contentTextView.font = UIFont.init(type: .PlayfairDisplay_Regular, size: CGFloat(currentFontSize))
    }
    
    @IBAction func didTapDecreaseFontButton(_ sender: UIButton) {
        currentFontSize -= 2
        if currentFontSize == 14 {
            self.disableButton(caller: self.decreaseFontButton)
        } else {
            self.enableButton(caller: self.decreaseFontButton)
        }
        if currentFontSize < 24 {
            self.enableButton(caller: self.increaseFontButton)
        }
        contentTextView.font = UIFont.init(type: .PlayfairDisplay_Regular, size: CGFloat(currentFontSize))
    }
    
    @IBAction func didTapNotesButton(_ sender: UIButton) {
        let vCnt = StoryboardScene.Main.NotesViewController.instantiate()
        vCnt.spell = spell
        self.navigationController?.pushViewController(vCnt, animated: true)
    }
    
}
