//
//  MealDB.swift
//  Recipe Book
//
//  Created by Chase on 3/29/23.
//

import Foundation

struct MealDBTopLevelDictionary: Decodable {
    let meals: [MealDBRecipe]
}

struct MealDBRecipe: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealName = "strMeal"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
        case ingredients
    }
    
    let mealID: String?
    let mealName: String?
    let instructions: String?
    let imageURL: String?
    let ingredients: [Ingredient]
    
    var ingredientString: String {
        var result: String = ""
        ingredients.forEach {
            let ingredientPair = "\($0.name): \($0.measurement)\n"
            result.append(ingredientPair)
        }
        return result
    }
}

struct Ingredient: Decodable {
    let name: String
    let measurement: String
}

// MARK: - Extensions
extension MealDBRecipe {
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        self.mealID = try? container?.decode(String.self, forKey: .mealID)
        self.mealName = try? container?.decode(String.self, forKey: .mealName)
        self.instructions = try? container?.decode(String.self, forKey: .instructions)
        self.imageURL = try? container?.decode(String.self, forKey: .imageURL)
        
        let ingredientNamesContainer = try? decoder.container(keyedBy: IngredientCodingKeys.self)
        let measurementsContainer = try? decoder.container(keyedBy: MeasurementsCodingKeys.self)
        
        let ingredients: [Ingredient] = IngredientCodingKeys.allCases.enumerated().compactMap {
            
            guard let name = try? ingredientNamesContainer?.decode(String.self, forKey: $0.element),
                  let measurement = try? measurementsContainer?.decode(String.self, forKey: MeasurementsCodingKeys.allCases[$0.offset]),
                  !name.isEmpty,
                  !measurement.isEmpty else { return nil }
            
            return Ingredient(name: name, measurement: measurement)
        }
        
        self.ingredients = ingredients
    }
    
    private enum IngredientCodingKeys: String, CodingKey, CaseIterable {
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
        case strIngredient16
        case strIngredient17
        case strIngredient18
        case strIngredient19
        case strIngredient20
    }
    
    private enum MeasurementsCodingKeys: String, CodingKey, CaseIterable {
        case strMeasure1
        case strMeasure2
        case strMeasure3
        case strMeasure4
        case strMeasure5
        case strMeasure6
        case strMeasure7
        case strMeasure8
        case strMeasure9
        case strMeasure10
        case strMeasure11
        case strMeasure12
        case strMeasure13
        case strMeasure14
        case strMeasure15
        case strMeasure16
        case strMeasure17
        case strMeasure18
        case strMeasure19
        case strMeasure20
    }
}
