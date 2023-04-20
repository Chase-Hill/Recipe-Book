//
//  CreateRecipeViewModel.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

protocol CreateRecipeViewModelDelegate: AnyObject {
    func addRecipe()
    func ingredientAdded()
}

class CreateRecipeViewModel {
    
    // MARK: - Properties
    var recipe: UserRecipe?
    var ingredients: [UserIngredient] = []
    
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
    
    func addIngredient(name: String, ammount: String, type: String) {
        let newIngredient = UserIngredient(ingredientName: name, measurementNumber: ammount, measurementType: type)
        ingredients.append(newIngredient)
        self.delegate?.ingredientAdded()
    }
}
