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
    
    // MARK: - Actions
    @IBAction func bookmarkButtonTapped(_ sender: Any) {
        
    }
    
    // MARK: - Functions
    func fetchImage(with recipe: MealDBRecipe) {
        guard let urlString = recipe.imageURL else { return }
        guard let imageURL = URL(string: urlString) else { return }
        mealImageView.fetchImage(using: imageURL)
    }
}
