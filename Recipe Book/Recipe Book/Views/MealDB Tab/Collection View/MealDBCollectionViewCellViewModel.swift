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
    var recipe: MealDBRecipe
    private weak var delegate: MealDBCollectionViewCellViewModelDelegate?
    
    init(recipe: MealDBRecipe, delegate: MealDBCollectionViewCellViewModelDelegate) {
        self.recipe = recipe
        self.delegate = delegate
        delegate.configure(with: recipe)
    }
}
