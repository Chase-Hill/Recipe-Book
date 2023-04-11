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
    var viewModel: MealDBInstructionsViewModel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
}

extension MealDBInstructionsViewController: MealDBInstructionsViewModelDelegate {
    func updateViews() {
            mealDBInstructionsTextView.text = viewModel.recipe.instructions
    }
}
