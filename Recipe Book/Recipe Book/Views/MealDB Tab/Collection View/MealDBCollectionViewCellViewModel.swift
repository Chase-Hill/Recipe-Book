//
//  MealDBCollectionViewCellViewModel.swift
//  Recipe Book
//
//  Created by Chase on 4/10/23.
//

import Foundation

protocol MealDBCollectionViewCellViewModelDelegate: AnyObject {
    func configure(with recipe: MealDBRecipe)
}

class MealDBCollectionViewCellViewModel {
    
    // MARK: - Properties
    private var service: FirebaseServicable
    var recipes: [MealDBRecipe] = []
    var recipe: MealDBRecipe
    private weak var delegate: MealDBCollectionViewCellViewModelDelegate?
    
    init(recipe: MealDBRecipe, delegate: MealDBCollectionViewCellViewModelDelegate, service: FirebaseServicable = FirebaseService()) {
        self.recipe = recipe
        self.delegate = delegate
        delegate.configure(with: recipe)
        self.service = service
    }
    
    // MARK: - Functions
    func saveToFavorites() {
        guard let id = recipe.mealID else { return }
        service.saveMealDBFavorite(with: id, from: recipe) {
            
        }
    }
}
