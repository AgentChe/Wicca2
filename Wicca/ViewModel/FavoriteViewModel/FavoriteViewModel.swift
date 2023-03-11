//
//  FavoriteViewModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 08/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

class FavoriteViewModel {
    
    func isFavorite(favorite: FavoriteModel) -> Bool {
        let existFavorites = getFavorites()
        let tempFavorites = existFavorites.filter({ (favModel) -> Bool in
            if favModel.favId == favorite.favId && favModel.favName == favorite.favName {
                return true
            } else {
                return false
            }
        })
        if tempFavorites.count == 1 &&
            tempFavorites[0].favId == favorite.favId &&
            tempFavorites[0].favName == favorite.favName {
            return true
        } else {
            return false
        }
    }
    
    func addFavorite(favorite: FavoriteModel) {
        let existFavorites = getFavorites()
        var tempFavDicArr: [[String: Any]] = []
        for dic in existFavorites {
            tempFavDicArr.append(dic.toDictionary())
        }
        tempFavDicArr.insert(favorite.toDictionary(), at: 0)
        do {
            let favoritesData = try NSKeyedArchiver.archivedData(withRootObject: tempFavDicArr, requiringSecureCoding: false)
            UserDefaults.standard.set(favoritesData, forKey: "Favorites")
            UserDefaults.standard.synchronize()
        } catch let err {
            debugPrint("Couldn't store favourite = \(err.localizedDescription)")
        }
    }
    
    func removeFavorite(favorite: FavoriteModel) {
        var existFavorites = getFavorites()
        existFavorites = existFavorites.filter({ (favModel) -> Bool in
            if favModel.favId == favorite.favId && favModel.favName == favorite.favName {
                return false
            } else {
                return true
            }
        })
        do {
            var tempFavDicArr: [[String: Any]] = []
            for dic in existFavorites {
                tempFavDicArr.append(dic.toDictionary())
            }
            let existFavorites = try NSKeyedArchiver.archivedData(withRootObject: tempFavDicArr, requiringSecureCoding: false)
            UserDefaults.standard.set(existFavorites, forKey: "Favorites")
            UserDefaults.standard.synchronize()
        } catch let err {
            debugPrint("Couldn't store favourite = \(err.localizedDescription)")
        }
    }
    
    func getFavorites() -> [FavoriteModel] {
        if let favoritesData = UserDefaults.standard.value(forKey: "Favorites") as? Data {
            do {
                if let favorites = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(favoritesData) as? [[String : Any]] {
                    var tempFavArr: [FavoriteModel] = []
                    for dic in favorites {
                        tempFavArr.append(FavoriteModel.init(fromDictionary: dic))
                    }
                    return tempFavArr
                } else {
                    return []
                }
            } catch let err {
                debugPrint("Couldn't read favourite = \(err.localizedDescription)")
                return []
            }
        } else {
            return []
        }
    }

}
