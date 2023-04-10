//
//  MealDBIngredientsViewModel.swift
//  Recipe Book
//
//  Created by Chase on 4/10/23.
//

import Foundation

protocol MealDBIngredientsViewModelDelegate: MealDBIngredientsTableViewController {
    // Note: - Need to inform the ViewController to update the views when the fetch is done
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
