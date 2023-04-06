//
//  MealDBInstructionsViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class MealDBInstructionsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mealDBInstructionsTextView: UITextView!
    
    // MARK: - Properties
    var recipe: MealDBRecipe?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: - Functions
    func updateUI() {
        guard let instructions = recipe?.instructions else { return }
        mealDBInstructionsTextView.text = instructions
    }
}
