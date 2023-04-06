//
//  MealDBIngredientsViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class MealDBIngredientsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mealDBIngredientsTextView: UITextView!
    
    // MARK: - Properties
    var recipe: MealDBRecipe?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Functions
    func updateUI() {
        guard let ingredients = recipe?.ingredientString else { return }
        mealDBIngredientsTextView.text = ingredients
    }
}
