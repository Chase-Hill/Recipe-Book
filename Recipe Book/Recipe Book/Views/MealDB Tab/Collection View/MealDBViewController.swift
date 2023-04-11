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
    @IBOutlet weak var mealDBCollectionView: UICollectionView!
    
    // MARK: - Properties
    var viewModel: MealDBViewModel!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mealDBSearchBar.delegate = self
        mealDBCollectionView.dataSource = self
        mealDBCollectionView.delegate = self
        viewModel = MealDBViewModel(delegate: self)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
    }
}

// MARK: - Extensions
extension MealDBViewController: MealDBViewModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.mealDBCollectionView.reloadData()
        }
    }
}

extension MealDBViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.meals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? MealDBCollectionViewCell else { return UICollectionViewCell() }
        let recipe = viewModel.meals[indexPath.item]
        cell.viewModel = MealDBCollectionViewCellViewModel(recipe: recipe, delegate: cell)
        
        return cell
    }
}

extension MealDBViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        viewModel.fetchRecipes(searchTerm: searchTerm)
    }
}
