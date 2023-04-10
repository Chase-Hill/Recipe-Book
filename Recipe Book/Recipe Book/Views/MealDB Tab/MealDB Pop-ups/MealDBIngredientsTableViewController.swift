//
//  MealDBIngredientsTableViewController.swift
//  Recipe Book
//
//  Created by Chase on 4/10/23.
//

import UIKit

class MealDBIngredientsTableViewController: UITableViewController {

    // MARK: - Properties
    var viewModel: MealDBIngredientsViewModel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipe.ingredients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealDBIngredientCell", for: indexPath)

        let ingredient = viewModel.recipe.ingredients[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = ingredient.name
        config.secondaryText = ingredient.measurement
        cell.contentConfiguration = config

        return cell
    }
}

extension MealDBIngredientsTableViewController: MealDBIngredientsViewModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
