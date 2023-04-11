//
//  FavoritesCollectionViewCell.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//

import UIKit

class FavoritesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var favoritesImageView: UIImageView!
    @IBOutlet weak var favoritesInstructionsLabel: UILabel!
    @IBOutlet weak var favoritesIngredientsLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func favoritesButtonTapped(_ sender: Any) {
    }
    
}
