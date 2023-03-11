//
//  StoryboardScene.swift
//  MyBestLife
//
//  Created by Jay Jariwala on 06/10/20.
//  Copyright © 2020 Jay Jariwala. All rights reserved.
//

import Foundation
import UIKit

private final class BundleToken {}

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: Bundle(for: BundleToken.self))
  }
}

internal struct SceneType<T: Any> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: Any> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal enum StoryboardScene {
    
    internal enum Main: StoryboardType {
        internal static let storyboardName = "Main"
        internal static let HomeViewController = SceneType<HomeViewController>(storyboard: Main.self, identifier: "HomeViewController")
        internal static let SpellsCategoryViewController = SceneType<CategoryViewController>(storyboard: Main.self, identifier: "CategoryViewController")
        internal static let SpellsViewController = SceneType<SubCategoryViewController>(storyboard: Main.self, identifier: "SubCategoryViewController")
        internal static let SideMenuViewController = SceneType<SideMenuViewController>(storyboard: Main.self, identifier: "SideMenuViewController")
        internal static let HerbsAndOilsViewController = SceneType<HerbsAndOilsViewController>(storyboard: Main.self, identifier: "HerbsAndOilsViewController")
        internal static let CalendarViewController = SceneType<CalenderViewController>(storyboard: Main.self, identifier: "CalenderViewController")
        internal static let LunarCalendarViewController = SceneType<LunarCalenderViewController>(storyboard: Main.self, identifier: "LunarCalenderViewController")
        internal static let FavoritesViewController = SceneType<FavoritesViewController>(storyboard: Main.self, identifier: "FavoritesViewController")
        internal static let ContentViewController = SceneType<ContentViewController>(storyboard: Main.self, identifier: "ContentViewController")
        internal static let CandleColorsViewController = SceneType<CandleColorsViewController>(storyboard: Main.self, identifier: "CandleColorsViewController")
        internal static let NotesViewController = SceneType<NotesViewController>(storyboard: Main.self, identifier: "NotesViewController")
        internal static let LunarMoonPhasesViewController = SceneType<LunarMoonPhasesViewController>(storyboard: Main.self, identifier: "LunarMoonPhasesViewController")
        internal static let AboutViewController = SceneType<AboutViewController>(storyboard: Main.self, identifier: "AboutViewController")
        internal static let UnlockWiccaViewController = SceneType<UnlockWiccaViewController>(storyboard: Main.self, identifier: "UnlockWiccaViewController")
    }
    
}
