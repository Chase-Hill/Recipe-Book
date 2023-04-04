//
//  Meal.swift
//  Recipe Book
//
//  Created by Chase on 4/3/23.
//

import Foundation

struct MealTopLevel: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImageURL = "strMealThumb"
        case mealID = "idMeal"
    }
    
    let mealName: String
    let mealImageURL: String
    let mealID: String
}
