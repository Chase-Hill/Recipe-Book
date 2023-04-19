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
        
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: Any) {
        
        guard let recipeName = recipeNameTextField.text,
              let instructions = createRecipeInstructionsTextView.text else { return }
        guard let image = UIImage(named: "cooking") else { return }
        testing()
        viewModel.saveRecipe(name: recipeName, instructions: instructions, ingredients: viewModel.ingredients, image: image)
    }
    
    func testing() {
        guard let cells = ingredientsTableView.visibleCells as? [IngredientsTableViewCell] else { return }
        for cell in cells {
//            ingredients.append(ingredient)
        }
    }
}

extension CreateRecipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = ingredientsTableView.dequeueReusableCell(withIdentifier: "userIngredientCell", for: indexPath) as? IngredientsTableViewCell else { return UITableViewCell() }
        cell.ingredientNameTextField.text = "Testing"
        cell.setUpPopUpButton()
        return cell
    }
}

extension CreateRecipeViewController: CreateRecipeViewModelDelegate {
    func addRecipe() {
        
    }
}
