//
//  MealDBIngredientsViewModel.swift
//  Recipe Book
//
//  Created by Chase on 4/10/23.
//

import Foundation

protocol MealDBIngredientsViewModelDelegate: AnyObject {
    func updateViews()
}

class MealDBIngredientsViewModel {
    
    // MARK: - Properties
    var recipe: MealDBRecipe
    private weak var delegate: MealDBIngredientsViewModelDelegate?
    
    // MARK: - Dependency Injection
    init(recipe: MealDBRecipe, delegate: MealDBIngredientsViewModelDelegate) {
        self.delegate = delegate
        self.recipe = recipe
    }
}
