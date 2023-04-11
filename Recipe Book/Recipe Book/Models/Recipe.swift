//
//  Recipe.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import Foundation

class Recipe {
    
    enum Key {
        static let instructions = "instructions"
        static let ingredients = "ingredients"
        static let image = "image"
        static let uuid = "uuid"
        static let collection = "recipes"
        static var isFavorited = "isFavorited"
    }
    
    var instructions: String
    var ingredients: String
    var image: String
    var uuid: String
    var isFavorited: Bool
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.instructions: self.instructions,
            Key.ingredients: self.ingredients,
            Key.image: self.image,
            Key.uuid: self.uuid,
            Key.isFavorited: self.isFavorited
        ]
    }
    
    init(instructions: String, ingredients: String, image: String, uuid: String = UUID().uuidString, isFavorited: Bool) {
        self.instructions = instructions
        self.ingredients = ingredients
        self.image = image
        self.uuid = uuid
        self.isFavorited = isFavorited
    }
}

extension Recipe {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let instructions = dictionary[Key.instructions] as? String,
              let ingredients = dictionary[Key.ingredients] as? String,
              let imageURL = dictionary[Key.image] as? String,
              let uuid = dictionary[Key.uuid] as? String,
              let isFavorited = dictionary[Key.isFavorited] else {print("Check model") ; return nil}
        
        self.init(instructions: instructions, ingredients: ingredients, image: imageURL, uuid: uuid, isFavorited: isFavorited as! Bool)
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
