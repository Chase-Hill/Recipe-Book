//
//  MealDBCollectionViewCell.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class MealDBCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var mealImageView: ServiceRequestingImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    // MARK: - Properties
    var viewModel: MealDBCollectionViewCellViewModel!
    
    // MARK: - Actions
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        #warning("Finish code here once funishing up Favorites folder.")
    }
    
    @IBAction func ingredientsButtonTapped(_ sender: Any) {
        presentIngredients()
    }
    
    @IBAction func instructionsButtonTapped(_ sender: Any) {
        presentInstructions()
    }
    
    // MARK: - Functions
    func presentIngredients() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mealTableViewController = storyboard.instantiateViewController(withIdentifier: "ingredientsModal") as? MealDBIngredientsTableViewController else { return }
        mealTableViewController.viewModel = MealDBIngredientsViewModel(recipe: viewModel.recipe, delegate: mealTableViewController)
        self.window?.rootViewController?.present(mealTableViewController, animated: true)
    }
    
    func presentInstructions() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mealInstructionsView = storyboard.instantiateViewController(withIdentifier: "instructionsModal") as? MealDBInstructionsViewController else { return }
        mealInstructionsView.viewModel = MealDBInstructionsViewModel(recipe: viewModel.recipe, delegate: mealInstructionsView)
        self.window?.rootViewController?.present(mealInstructionsView, animated: true)
    }
}

extension MealDBCollectionViewCell: MealDBCollectionViewCellViewModelDelegate {
    func configure(with recipe: MealDBRecipe) {
        recipeNameLabel.text = recipe.mealName
        guard let url = URL(string: recipe.imageURL ?? "No URL Found") else { return }
        mealImageView.fetchImage(using: url)
    }
}
