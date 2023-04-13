//
//  MealDBViewController.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

// Note: - We want to switch the data depending on the segmented control. We want to switch the data based on the segmented index. If index == 0 we want the search by name, if index == 1 we want the favorites.

class MealDBViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mealDBSearchBar: UISearchBar!
    @IBOutlet weak var mealDBCollectionView: UICollectionView!
    @IBOutlet weak var mealDBSegmentedControl: UISegmentedControl!
    
    // MARK: - Properties
    var viewModel: MealDBViewModel!
    var dataSource: [MealDBRecipe] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mealDBSearchBar.delegate = self
        mealDBCollectionView.dataSource = self
        mealDBCollectionView.delegate = self
        viewModel = MealDBViewModel(delegate: self)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        mealDBSegmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        setUpDatasource()
        fetch()
    }
    
    // MARK: - Actions
    @objc func segmentChanged() {
        // Note: - Datasource = Segmentedcontrol.selectedSegmentIndex
        setUpDatasource()
        mealDBCollectionView.reloadData()
    }
    
    func setUpDatasource() {
        dataSource = mealDBSegmentedControl.selectedSegmentIndex == 0 ? viewModel.meals : viewModel.favoriteMeals
    }
    
    func fetch() {
        viewModel.fetchFavoritesFromFirebase()
    }
}

// MARK: - Extensions
extension MealDBViewController: MealDBViewModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.setUpDatasource()
            self.mealDBCollectionView.reloadData()
        }
    }
}

extension MealDBViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recipeCell", for: indexPath) as? MealDBCollectionViewCell else { return UICollectionViewCell() }
        let recipe = dataSource[indexPath.item]
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
