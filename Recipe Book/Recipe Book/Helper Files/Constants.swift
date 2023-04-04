//
//  Constants.swift
//  Recipe Book
//
//  Created by Chase on 4/4/23.
//

import Foundation

struct Constants {
    // www.themealdb.com/api/json/v2/9973533/search.php?s=Chicken
    
    struct MealDB {
        static let baseURL = "www.themealdb.com/api/json/v2/9973533"
        static let searchPath = "/search.php"
        static let searchQuery = "s"
    }
}
