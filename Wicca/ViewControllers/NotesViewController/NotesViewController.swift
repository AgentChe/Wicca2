//
//  NotesViewController.swift
//  Wicca
//
//  Created by Jay Jariwala on 19/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation
import UIKit

class NotesViewController: BaseVc {

    // MARK: Outlet
    @IBOutlet weak var spellTitleLabel: UILabel!
    @IBOutlet weak var notesTextView: UITextView!
    
    /// NSLayoutConstraint
    
    // MARK: Variables & Constants
    var spell: SpellModel!
    
    // MARK: Initializers

}

// MARK:- Overided funtions (Defaults and Customs)
extension NotesViewController {
    
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
extension NotesViewController {
    
    override func setupHeader() {
        
    }
    
    override func initialUISetup() {
        spellTitleLabel.text = spell.spellName
        notesTextView.text = UserDefaults.standard.string(forKey: "\(spell.spellName)")
        
        let notesToolBar = UIToolbar()
        notesToolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done".localize, style: .plain, target: self, action: #selector(didTapDoneButton))
        notesToolBar.setItems([spaceButton,doneButton], animated: false)
        notesTextView.inputAccessoryView = notesToolBar
    }
    
    override func initialDataSetup() {
        
    }
    
}

// MARK:- Action Perform By Selectors
extension NotesViewController {
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapDoneButton() {
        self.view.endEditing(true)
        UserDefaults.standard.set(self.notesTextView.text, forKey: "\(spell.spellName)")
        UserDefaults.standard.synchronize()
    }
    
}
