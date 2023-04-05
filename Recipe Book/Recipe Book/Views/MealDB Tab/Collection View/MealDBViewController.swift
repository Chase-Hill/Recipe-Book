//
//  MealDBViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class MealDBViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mealDBSearchBar: UISearchBar!
    
    // MARK: - Properties
    var viewModel: MealDBViewModel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Note: - Set my GOD DAMN DELEGATE
        mealDBSearchBar.delegate = self
        viewModel = MealDBViewModel(delegate: self)
    }
    
    // MARK: - Functions
    
}

// MARK: - Extensions
extension MealDBViewController: MealDBViewModelDelegate {
    func updateViews() {
        // Note: - Finish the code 
    }
}

extension MealDBViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        viewModel.fetchRecipes(searchTerm: searchTerm)
    }
}
