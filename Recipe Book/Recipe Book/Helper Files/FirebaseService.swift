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
    func save(instructions: String, ingredients: String, image: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
    }
    
//    func loadRecipes(completion: @escaping (Result <[Recipe], NetworkError>) -> Void) {
//        ref.collection(Recipe.Key.collection).getDocuments { snapshot, error in
//            if let error = error {
//                print(error.localizedDescription)
//                completion(.failure(.thrownError(error)))
//            }
//
//            guard let docSnapshot = snapshot?.documents else { completion(.failure(.noData)) ; return }
//            let dictionaryArray = docSnapshot.compactMap { Recipe(fromDictionary: $0) }
//            completion(.success(<#T##[Recipe]#>))
//        }
//    }
}
