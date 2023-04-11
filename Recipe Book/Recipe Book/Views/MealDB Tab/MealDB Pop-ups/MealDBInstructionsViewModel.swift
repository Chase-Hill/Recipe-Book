//
//  MealDBInstructionsViewModel.swift
//  Recipe Book
//
//  Created by Chase on 4/10/23.
//

import Foundation

protocol MealDBInstructionsViewModelDelegate: MealDBInstructionsViewController {
    // Note: - Need to inform the ViewController to update the views when the fetch is done
    func updateViews()
}

class MealDBInstructionsViewModel {
    
    // MARK: - Properties
    var recipe: MealDBRecipe
    private weak var delegate: MealDBInstructionsViewModelDelegate?
    
    // MARK: - Dependency Injection
    init(recipe: MealDBRecipe, delegate: MealDBInstructionsViewModelDelegate) {
        self.delegate = delegate
        self.recipe = recipe
    }
}
