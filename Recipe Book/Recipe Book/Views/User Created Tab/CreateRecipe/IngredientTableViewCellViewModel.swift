//
//  IngredientTableViewCellViewModel.swift
//  Recipe Book
//
//  Created by Chase on 4/18/23.
//

import UIKit

protocol IngredientTableViewCellViewModelDelegate: AnyObject {
    func updateIngredient(ingredient: UserIngredient)
}

struct IngredientTableViewCellViewModel {
    
     // MARK: - Properties
    private weak var delegate: IngredientTableViewCellViewModelDelegate?
    
    init(delegate: IngredientTableViewCellViewModelDelegate) {
        self.delegate = delegate
    }
}
