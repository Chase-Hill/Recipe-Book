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
	@IBOutlet weak var instructionsLabel: UILabel!
	@IBOutlet weak var ingredientsLabel: UILabel!

	// MARK: - Actions
	@IBAction func bookmarkButtonTapped(_ sender: Any) {

	}

	// MARK: - Functions
	func fetchImage(with recipe: MealDBRecipe) {
		guard let urlString = recipe.imageURL else { return }
		guard let imageURL = URL(string: urlString) else { return }
		mealImageView.fetchImage(using: imageURL)
	}

	func configUI(with recipe: MealDBRecipe) {
		DispatchQueue.main.async {
			self.recipeNameLabel.text = recipe.mealName
		}
	}

	override func prepareForReuse() {
		// MAXPOFF - these are probably not neccessary. This was me trying to figure out a different path, but idk, my bff Jill
//		instructionsLabel.gestureRecognizers?.removeAll()
//		ingredientsLabel.gestureRecognizers?.removeAll()
	}
}
