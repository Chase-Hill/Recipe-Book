//
//  CreateRecipeViewModel.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

protocol CreateRecipeViewModelDelegate: AnyObject {
    func addRecipe()
}

class CreateRecipeViewModel {
    
    // MARK: - Properties
    var recipe: UserRecipe?
    var ingredients: [UserIngredient] = []
    var cell: IngredientsTableViewCell?
    
    // MARK: - Dependencies
    private var service: FirebaseServicable
    private weak var delegate: CreateRecipeViewModelDelegate?
    
    init(service: FirebaseServicable = FirebaseService(), delegate: CreateRecipeViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - Functions
    func saveRecipe(name: String, instructions: String, ingredients: [UserIngredient], image: UIImage) {
        service.saveRecipe(name: name, instructions: instructions, ingredients: ingredients, image: image) {
            self.delegate?.addRecipe()
        }
    }
    

}
