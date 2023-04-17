//
//  MealDBViewModel.swift
//  Recipe Book
//
//  Created by Chase on 3/30/23.
//
import UIKit

protocol MealDBViewModelDelegate: AnyObject {
    func updateViews()
}

class MealDBViewModel {
    
    // MARK: - Properties
    let group = DispatchGroup()
    var recipe: MealDBRecipe?
    var mealDB: MealDBTopLevelDictionary?
    var meals: [MealDBRecipe] = []
    var favoriteMeals: [MealDBRecipe] = []
    
    private var mealService: MealServiceable
    private var fireService: FirebaseServicable
    private weak var delegate: MealDBViewModelDelegate?
    
    // Note: - Dependancy Injection
    init(delegate: MealDBViewModelDelegate, mealService: MealServiceable = MealService(), fireService: FirebaseServicable = FirebaseService()) {
        self.delegate = delegate
        self.mealService = mealService
        self.fireService = fireService
    }
    
    // MARK: - Functions
    func fetchRecipes(searchTerm: String) {
        mealService.fetchMealsByName(searchTerm: searchTerm) { result in
            switch result {
            case .success(let meals):
                self.meals = meals
                self.delegate?.updateViews()
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
    
    func fetchFavoritesFromFirebase() {
        fireService.loadMealdDBFavorites { result in
            switch result {
            case .success(let meals):
                print(meals)
                self.fetchAllMealsByID(meals: meals)
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
    
    func fetchAllMealsByID(meals: [MealDBToLoad]) {
        var mealsToReturn: [MealDBRecipe] = []
        DispatchQueue.global(qos: .userInitiated).async {
            for meal in meals {
                self.group.enter()
                self.fetchMealsByID(meal: meal, completion: { meal in
                    if let meal = meal {
                        mealsToReturn.append(meal)
                    }
                    self.group.leave()
                })
            }
            self.group.wait()
            DispatchQueue.main.async {
                print("Dispatch Group Finished")
                self.favoriteMeals = mealsToReturn
            }
            self.delegate?.updateViews()
        }
    }
    
    func fetchMealsByID(meal: MealDBToLoad, completion: @escaping (_: MealDBRecipe?) -> Void) {
        mealService.fetchMealsByID(id: meal.id) { result in
            switch result {
            case .success(let meal):
                return completion(meal)
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
