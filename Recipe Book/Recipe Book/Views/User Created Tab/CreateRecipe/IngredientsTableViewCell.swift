//
//  IngredientsTableViewCell.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var viewModel: IngredientTableViewCellViewModel!
    
    // MARK: - Outlets
    @IBOutlet weak var ingredientNameTextField: UITextField!
    @IBOutlet weak var measurementAmountTextField: UITextField!
    @IBOutlet weak var measurementTypeButton: UIButton!
    
    // MARK: - Functions
    func setUpPopUpButton() {
        let closure = { (action: UIAction) in
            print(action.title)
        }
        measurementTypeButton.menu = UIMenu(children: [
            UIAction(title: "↓", attributes: .hidden, state: .on, handler: closure),
            UIAction(title: "Cups", handler: closure),
            UIAction(title: "Tbsp", handler: closure),
            UIAction(title: "Tsp", handler: closure),
            UIAction(title: "Pinch", handler: closure),
            UIAction(title: "Dash", handler: closure),
            UIAction(title: "Lbs", handler: closure),
            UIAction(title: "Oz", handler: closure),
            UIAction(title: "Kg", handler: closure),
            UIAction(title: "Grams", handler: closure),
            UIAction(title: "L", handler: closure),
            UIAction(title: "Ml", handler: closure)
        ])
        measurementTypeButton.showsMenuAsPrimaryAction = true
        measurementTypeButton.changesSelectionAsPrimaryAction = true
    }
}

extension IngredientsTableViewCell: IngredientTableViewCellViewModelDelegate {
    func updateIngredient(ingredient: UserIngredient) {
        ingredientNameTextField.text = ingredient.ingredientName
        measurementAmountTextField.text = ingredient.measurementNumber
        measurementTypeButton.titleLabel?.text = ingredient.measurementType
    }
}
