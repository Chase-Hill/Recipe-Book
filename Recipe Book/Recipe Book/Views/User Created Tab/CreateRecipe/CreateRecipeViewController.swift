//
//  CreateRecipeViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

// Note: - Access each cell in the table view one at a time to retrieve the ingredient from it and add it to an array. Then, pass it into my initializer.

class CreateRecipeViewController: UIViewController {

    // MARK: - Properties
    var viewModel: CreateRecipeViewModel!
    var cell: IngredientsTableViewCell?
    
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
        viewModel.addIngredient(name: "", ammount: "", type: "")
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: Any) {
        
        guard let recipeName = recipeNameTextField.text,
              let instructions = createRecipeInstructionsTextView.text else { return }
        guard let image = UIImage(named: "cooking") else { return }
        viewModel.saveRecipe(name: recipeName, instructions: instructions, ingredients: viewModel.ingredients, image: image)
    }
}

extension CreateRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "userIngredientCell", for: indexPath) as? IngredientsTableViewCell else { return UITableViewCell() }
        cell.setUpPopUpButton()
        let ingredient = viewModel.ingredients[indexPath.row]
        cell.updateIngredient(with: ingredient)
        return cell
    }
}

extension CreateRecipeViewController: CreateRecipeViewModelDelegate {
    func addRecipe() {
        
    }
    
    func ingredientAdded() {
        ingredientsTableView.reloadData()
    }
}
