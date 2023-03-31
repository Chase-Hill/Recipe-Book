//
//  UserCreatedCollectionViewCell.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class UserCreatedCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var userCreatedImageView: UIImageView!
    @IBOutlet weak var userCreatedInstructionsLabel: UILabel!
    @IBOutlet weak var userCreatedIngredientsLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func favoriteButtonTapped(_ sender: Any) {
    }
    @IBAction func deleteRecipeButtonTapped(_ sender: Any) {
    }
}
