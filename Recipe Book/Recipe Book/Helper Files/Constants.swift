//
//  Constants.swift
//  Recipe Book
//
//  Created by Chase on 4/4/23.
//

import Foundation

struct Constants {
    
    struct MealDB {
        static let baseURL = "https://www.themealdb.com/api/json/v2/9973533"
        static let searchPath = "/search.php"
        static let searchQuery = "s"
        static let lookupIDPath = "/lookup.php"
        static let lookupIDQuery = "i"
        static let collectionRef = "MealDBFavorites"
    }
    
    struct RecipeImage {
        static let imageRef = "images"
    }
}
