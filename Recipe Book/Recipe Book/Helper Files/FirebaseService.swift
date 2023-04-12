//
//  FirebaseService.swift
//  Recipe Book
//
//  Created by Chase on 4/3/23.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage

protocol FirebaseServicable {
    func saveRecipe(instructions: String, ingredients: String, image: UIImage, completion: @escaping () -> Void)
    func loadRecipes(completion: @escaping (Result <[Recipe], NetworkError>) -> Void)
    func deleteRecipe(with recipe: Recipe)
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result <URL, NetworkError>) -> Void)
    func fetchImage(from recipe: Recipe, completion: @escaping (Result <UIImage, NetworkError>) -> Void)
    func deleteImage(from recipe: Recipe)
}

struct FirebaseService: FirebaseServicable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    // MARK: - Functions
    func saveRecipe(instructions: String, ingredients: String, image: UIImage, completion: @escaping () -> Void) {
        
        let uuid = UUID().uuidString
        
        saveImage(image, with: uuid) { result in
            switch result {
            case .success(let imageURL):
                let recipe = Recipe(instructions: instructions, ingredients: ingredients, image: imageURL.absoluteString, isFavorited: false)
                ref.collection(Recipe.Key.collection).document(recipe.uuid).setData(recipe.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure) ; return
            }
        }
    }
    
    func loadRecipes(completion: @escaping (Result <[Recipe], NetworkError>) -> Void) {
        ref.collection(Recipe.Key.collection).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error))) ; return
            }
            
            guard let docSnapshot = snapshot?.documents else { completion(.failure(.noData)) ; return }
            
            let dictionaryArray = docSnapshot.compactMap { $0.data() }
            let recipes = dictionaryArray.compactMap { Recipe(fromDictionary: $0) }
            completion(.success(recipes))
        }
    }
    
    func deleteRecipe(with recipe: Recipe) {
        ref.collection(Recipe.Key.collection).document(recipe.uuid).delete()
        deleteImage(from: recipe)
    }
    
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result <URL, NetworkError>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        let uploadTask = storage.child(Constants.RecipeImage.imageRef).child(uuidString).putData(imageData, metadata: uploadMetadata) { _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error)))
            }
        }
        
        uploadTask.observe(.success) { _ in
            print("Uploaded image")
            self.storage.child(Constants.RecipeImage.imageRef).child(uuidString).downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(.thrownError(error)))
                }
                
                if let url {
                    print("Image URL: \(url)")
                    completion(.success(url))
                }
            }
        }
        
        uploadTask.observe(.failure) { snapshot in
            completion(.failure(.thrownError(snapshot.error!))) ; return
        }
    }
    
    func fetchImage(from recipe: Recipe, completion: @escaping (Result <UIImage, NetworkError>) -> Void) {
        storage.child(Constants.RecipeImage.imageRef).child(recipe.uuid).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.thrownError(error))) ; return
            }
        }
    }
    
    func deleteImage(from recipe: Recipe) {
        storage.child(Constants.RecipeImage.imageRef).child(recipe.uuid).delete(completion: nil)
    }
}
