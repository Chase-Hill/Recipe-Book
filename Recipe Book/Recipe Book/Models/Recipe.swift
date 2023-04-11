//
//  Recipe.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import Foundation

class Recipe {
    
    enum Key {
        static let user = "user"
        static let instructions = "instructions"
        static let ingredients = "ingredients"
        static let image = "image"
        static let uuid = "uuid"
        static let collection = "recipes"
    }
    
    var user: String
    var instructions: String
    var ingredients: String
    var image: String
    var uuid: String
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.user: self.user,
            Key.instructions: self.instructions,
            Key.ingredients: self.ingredients,
            Key.image: self.image,
            Key.uuid: self.uuid
        ]
    }
    
    init(user: String, instructions: String, ingredients: String, image: String, uuid: String = UUID().uuidString) {
        self.user = user
        self.instructions = instructions
        self.ingredients = ingredients
        self.image = image
        self.uuid = uuid
    }
}

extension Recipe {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let user = dictionary[Key.user] as? String,
              let instructions = dictionary[Key.instructions] as? String,
              let ingredients = dictionary[Key.ingredients] as? String,
              let imageURL = dictionary[Key.image] as? String,
              let uuid = dictionary[Key.uuid] as? String else {print("Check model for bullshittery") ; return nil}
        
        self.init(user: user, instructions: instructions, ingredients: ingredients, image: imageURL, uuid: uuid)
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
