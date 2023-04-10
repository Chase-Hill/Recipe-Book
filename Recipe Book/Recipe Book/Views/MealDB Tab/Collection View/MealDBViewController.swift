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
        cell.configUI(with: recipe)
        cell.fetchImage(with: recipe)
        
        let instructionsTapGesture = UITapGestureRecognizer(target: self, action: #selector(instructionsLabelTapped(_:)))
        let ingredientsTapGesture = UITapGestureRecognizer(target: self, action: #selector(ingredientsLabelTapped(_:)))
        cell.mealDBInstructionsLabel.addGestureRecognizer(instructionsTapGesture)
        cell.mealDBIngredientsLabel.addGestureRecognizer(ingredientsTapGesture)
        
        return cell
    }
    
    @objc func instructionsLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let modalViewController = self.storyboard?.instantiateViewController(withIdentifier: "instructionsModal") else { return }
        self.present(modalViewController, animated: true, completion: nil)
    }
    
    @objc func ingredientsLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let mealTableViewController = storyboard?.instantiateViewController(withIdentifier: "ingredientsModal") as? MealDBIngredientsTableViewController,
              let recipe = viewModel.recipe else { return }
        mealTableViewController.viewModel = MealDBIngredientsViewModel(recipe: recipe, delegate: mealTableViewController)
        self.present(mealTableViewController, animated: true)
//        guard let mealTableViewController = mealDBCollectionView.delegate as? MealDBIngredientsTableViewController else { return }
//        guard let modalViewController = viewController.storyboard?.instantiateViewController(withIdentifier: "ingredientsModal") else { return }
//        viewController.present(modalViewController, animated: true, completion: nil)
    }
}

extension MealDBViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        viewModel.fetchRecipes(searchTerm: searchTerm)
    }
}
