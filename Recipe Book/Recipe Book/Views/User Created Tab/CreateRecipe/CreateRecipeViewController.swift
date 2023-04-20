//
//  CreateRecipeViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

// Note: - I need to get the information from my outlets in my custom cell.

class CreateRecipeViewController: UIViewController {

    // MARK: - Properties
    var viewModel: CreateRecipeViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var createRecipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var createRecipeInstructionsTextView: UITextView!
    @IBOutlet weak var recipeNameTextField: UITextField!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateRecipeViewModel(delegate: self)
        ingredientsTableView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        viewModel.ingredients.append(UserIngredient(ingredientName: "", measurementNumber: "", measurementType: ""))
        ingredientsTableView.reloadData()
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: Any) {
        guard let recipeName = recipeNameTextField.text,
              let instructions = createRecipeInstructionsTextView.text,
              let image = createRecipeImageView.image else { return }
        viewModel.saveRecipe(name: recipeName, instructions: instructions, ingredients: viewModel.ingredients, image: image)
    }
}

extension CreateRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "userIngredientCell", for: indexPath) as? IngredientsTableViewCell else { return UITableViewCell() }
        cell.setUpPopUpButton()
        let ingredient = viewModel.ingredients[indexPath.row]
        cell.updateIngredient(ingredient: ingredient)
        return cell
    }
}

extension CreateRecipeViewController: CreateRecipeViewModelDelegate {
    func addRecipe() {
        // Note: - Pop view controller back to collection view and reload the view
    }
    
    func ingredientAdded() {
        ingredientsTableView.reloadData()
    }
}
