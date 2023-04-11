//
//  FirebaseService.swift
//  Recipe Book
//
//  Created by Chase on 4/3/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

struct FirebaseService {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    // MARK: - Functions
    func saveRecipe(instructions: String, ingredients: String, image: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
    }
}
