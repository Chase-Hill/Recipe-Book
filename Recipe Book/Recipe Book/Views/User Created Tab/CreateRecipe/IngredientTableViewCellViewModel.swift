//
//  IngredientTableViewCellViewModel.swift
//  Recipe Book
//
//  Created by Chase on 4/18/23.
//

import UIKit

protocol IngredientTableViewCellViewModelDelegate: AnyObject {
    func addIngredient()
}

struct IngredientTableViewCellViewModel {
    
     // MARK: - Properties
    let recipe: UserRecipe
    
    // MARK: - Functions

}
