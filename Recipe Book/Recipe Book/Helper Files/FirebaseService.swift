//
//  FirebaseService.swift
//  Recipe Book
//
//  Created by Chase on 4/3/23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

protocol FirebaseServicable {
    func saveRecipe(name: String, instructions: String, ingredients: [UserIngredient
    ], image: UIImage, completion: @escaping () -> Void)
    func loadRecipes(completion: @escaping (Result <[UserRecipe], NetworkError>) -> Void)
    func deleteRecipe(with recipe: UserRecipe)
    func saveImage(_ image: UIImage, with uuidString: String, completion: @escaping (Result <URL, NetworkError>) -> Void)
    func fetchImage(from recipe: UserRecipe, completion: @escaping (Result <UIImage, NetworkError>) -> Void)
    func deleteImage(from recipe: UserRecipe)
    func saveMealDBFavorite(with id: String, from mealDBRecipe: MealDBRecipe, completion: @escaping () -> Void)
    func loadMealdDBFavorites(completion: @escaping (Result <[MealDBToLoad], NetworkError>) -> Void)
}

struct FirebaseService: FirebaseServicable {
    
    // MARK: - Properties
    let ref = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    // MARK: - Functions
    func saveRecipe(name: String, instructions: String, ingredients: [UserIngredient
    ], image: UIImage, completion: @escaping () -> Void) {
        let uuid = UUID().uuidString
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        saveImage(image, with: uuid) { result in
            switch result {
            case .success(let imageURL):
                let recipe = UserRecipe(name: name, instructions: instructions, ingredients: ingredients, image: imageURL.absoluteString, isFavorited: false)
                ref.collection(Constants.Collections.userRef).document(userID).collection(Constants.Collections.userRecipes).document(recipe.uuid).setData(recipe.dictionaryRepresentation)
                completion()
            case .failure(let failure):
                print(failure) ; return
            }
        }
    }
    
    func loadRecipes(completion: @escaping (Result <[UserRecipe], NetworkError>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.collection(Constants.Collections.userRef).document(userID).collection(Constants.Collections.userRecipes).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error))) ; return
            }
            
            guard let docSnapshot = snapshot?.documents else { completion(.failure(.noData)) ; return }
            
            let dictionaryArray = docSnapshot.compactMap { $0.data() }
            let recipes = dictionaryArray.compactMap { UserRecipe(fromDictionary: $0) }
            completion(.success(recipes))
        }
    }
    
    func deleteRecipe(with recipe: UserRecipe) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.collection(Constants.Collections.userRef).document(userID).collection(Constants.Collections.userRecipes).document(recipe.uuid).delete()
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
    
    func fetchImage(from recipe: UserRecipe, completion: @escaping (Result <UIImage, NetworkError>) -> Void) {
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
    
    func deleteImage(from recipe: UserRecipe) {
        storage.child(Constants.RecipeImage.imageRef).child(recipe.uuid).delete(completion: nil)
    }
    
    func saveMealDBFavorite(with id: String, from mealDBRecipe: MealDBRecipe, completion: @escaping () -> Void) {
        guard let mealDBRecipeID = mealDBRecipe.mealID else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }

        ref.collection(Constants.Collections.userRef).document(userID).collection(Constants.Collections.mealDBFavorites).document(mealDBRecipeID).setData(["ID" : mealDBRecipeID])
        completion()
    }
    
    func loadMealdDBFavorites(completion: @escaping (Result <[MealDBToLoad], NetworkError>) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.collection(Constants.Collections.userRef).document(userID).collection(Constants.Collections.mealDBFavorites).getDocuments { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.thrownError(error))) ; return
            }
            
            guard let docSnapshot = snapshot?.documents else { completion(.failure(.noData)) ; return }
            
            let dictionaryArray = docSnapshot.compactMap { $0.data() }
            print(dictionaryArray)
            let recipes = dictionaryArray.compactMap { MealDBToLoad(fromDictionary: $0) }
            completion(.success(recipes))
        }
    }
    
    func deleteMealDBFavorite(from mealDBRecipe: MealDBRecipe) {
        guard let mealDBRecipeID = mealDBRecipe.mealID else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref.collection(Constants.Collections.userRef).document(userID).collection(Constants.Collections.mealDBFavorites).document(mealDBRecipeID).delete()
    }
}
