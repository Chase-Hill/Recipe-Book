//
//  MealService.swift
//  Recipe Book
//
//  Created by Chase on 4/3/23.
//

import UIKit

struct MealService {
    
    // MARK: - Properties
    let service = APIService()
    
    // MARK: - Functions
    func fetchMealsByName(searchTerm: String, completion: @escaping(Result <[MealDBRecipe], NetworkError>) -> Void) {
        guard let baseURL = URL(string: Constants.MealDB.baseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.MealDB.searchPath)
        let recipeNameQueryItem = URLQueryItem(name: Constants.MealDB.searchQuery, value: searchTerm)
        urlComponents?.queryItems = [recipeNameQueryItem]
        
        guard let finalURl = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Final Recipe URL: \(finalURl)")
        
        URLSession.shared.dataTask(with: finalURl) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Recipe Search Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                let recipes = try JSONDecoder().decode(MealDBTopLevelDictionary.self, from: data)
                completion(.success(recipes.meals))
            } catch {
                completion(.failure(.unableToDecode)) ; return
            }
        } .resume()
    }
    
//    func fetchMealsByIngredients(searchTerm: String, completion: @escaping(Result <[],>) -> Void) {
//
//    }
}
