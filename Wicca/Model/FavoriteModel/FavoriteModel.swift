//
//  FavoriteModel.swift
//  Wicca
//
//  Created by Jay Jariwala on 08/02/21.
//  Copyright © 2021 Jay Jariwala. All rights reserved.
//

import Foundation

class FavoriteModel {
    
    var favId: Int = 0
    var favName: String = ""
    var content: String = ""
    var favType: String = ""
    
    init() { }
    
    convenience init(favId: Int, favName: String, content: String, favType: String) {
        self.init()
        self.favId = favId
        self.favName = favName
        self.content = content
        self.favType = favType
    }
    
    convenience init(fromDictionary dictionary: [String:Any]) {
        self.init()
        favId = dictionary["favId"] as! Int
        favName = dictionary["favName"] as! String
        content = dictionary["content"] as! String
        favType = dictionary["favType"] as! String
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        dictionary["favId"] = self.favId
        dictionary["favName"] = self.favName
        dictionary["content"] = self.content
        dictionary["favType"] = self.favType
        return dictionary
    }
}
