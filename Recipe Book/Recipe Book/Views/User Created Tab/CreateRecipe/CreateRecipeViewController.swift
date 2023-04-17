//
//  CreateRecipeViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class CreateRecipeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var createRecipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var createRecipeInstructionsTextView: UITextView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func addIngredientButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func saveRecipeButtonTapped(_ sender: Any) {
        
    }
}
