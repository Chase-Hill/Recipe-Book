//
//  MealDBViewModel.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//
import Foundation

protocol MealDBViewModelDelegate: MealDBViewController {
    // Note: - Need to inform the ViewController to update the views when the fetch is done
    func updateViews()
}

// Note: - This is a concrete type
class MealDBViewModel {
    
    // MARK: - Properties
    var mealDB: MealDBTopLevelDictionary?
    var meals: [MealDBRecipe] = []
    let service: MealService // Note: - This is a concrete type
    private weak var delegate: MealDBViewModelDelegate?
    
    // Note: - Dependancy Injection
    init(delegate: MealDBViewModelDelegate, service: MealService = MealService()) {
        self.delegate = delegate
        self.service = service
    }
    
    // MARK: - Functions
    func fetchRecipes(searchTerm: String) {
        service.fetchMealsByName(searchTerm: searchTerm) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                self.delegate?.updateViews()
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
