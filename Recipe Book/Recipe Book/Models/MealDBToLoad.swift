//
//  MealDBToLoad.swift
//  Recipe Book
//
//  Created by Chase on 4/13/23.
//

import Foundation

class MealDBToLoad {
    
    enum Key {
        static let id = "ID"
    }
    
    var id: String
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.id: self.id
        ]
    }
    
    init(id: String) {
        self.id = id
    }
}

extension MealDBToLoad {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let id = dictionary[Key.id] as? String else { return nil }
        self.init(id: id)
    }
}

