//
//  Recipe.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import Foundation

// Note: - Explain what line 35 is doing in my own words and why it works.

class UserRecipe {
    
    enum Key {
        static let recipeName = "recipeName"
        static let instructions = "instructions"
        static let ingredients = "ingredients"
        static let image = "image"
        static let uuid = "uuid"
        static let collection = "recipes"
        static var isFavorited = "isFavorited"
    }
    
    var recipeName: String
    var instructions: String
    var ingredients: [UserIngredient]
    var image: String
    var uuid: String
    var isFavorited: Bool
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.recipeName: self.recipeName,
            Key.instructions: self.instructions,
            Key.ingredients: self.ingredients.map{ $0.dictionaryRepresentation },
            Key.image: self.image,
            Key.uuid: self.uuid,
            Key.isFavorited: self.isFavorited
        ]
    }
    
    init(name: String, instructions: String, ingredients: [UserIngredient], image: String, uuid: String = UUID().uuidString, isFavorited: Bool) {
        self.recipeName = name
        self.instructions = instructions
        self.ingredients = ingredients
        self.image = image
        self.uuid = uuid
        self.isFavorited = isFavorited
    }
}

struct UserIngredient: Decodable, Hashable {
    
    enum Key {
        static let ingredientName = "ingredientName"
        static let measurementNumber = "measurementNumber"
        static let measurementType = "measurementType"
    }

    var ingredientName: String
    var measurementNumber: String
    var measurementType: String
    
    var dictionaryRepresentation: [String : AnyHashable] {
        [
            Key.ingredientName: self.ingredientName,
            Key.measurementNumber: self.measurementNumber,
            Key.measurementType: self.measurementType
        ]
    }
}

extension UserRecipe {
    convenience init?(fromDictionary dictionary: [String : Any]) {
        guard let recipeName = dictionary[Key.recipeName] as? String,
              let instructions = dictionary[Key.instructions] as? String,
              let ingredients = dictionary[Key.ingredients] as? [UserIngredient],
              let imageURL = dictionary[Key.image] as? String,
              let uuid = dictionary[Key.uuid] as? String,
              let isFavorited = dictionary[Key.isFavorited] else {print("Check model") ; return nil}
        
        self.init(name: recipeName, instructions: instructions, ingredients: ingredients, image: imageURL, uuid: uuid, isFavorited: isFavorited as! Bool)
    }
}

extension UserRecipe: Equatable {
    static func == (lhs: UserRecipe, rhs: UserRecipe) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
