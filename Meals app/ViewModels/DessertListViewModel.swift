//
//  DesserListViewModel.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI
import Combine

/// Identifiable error for displaying error messages in alerts.
struct IdentifiableError: Identifiable {
    let id = UUID() // Ensures each instance has a unique identifier
    let message: String
}

/// ViewModel for managing the list of desserts.
class DessertListViewModel: ObservableObject {
    @Published var meals: [MealDetail] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Fetches the list of desserts and their detailed information.
    func fetchDesserts() {
        isLoading = true
        errorMessage = nil
        APIService.shared.fetchDesserts()
            .flatMap { meals in
                Publishers.MergeMany(meals.map { meal in
                    APIService.shared.fetchMealDetail(by: meal.id)
                        .tryMap { mealDetail -> MealDetail in
                            mealDetail
                        }
                        .catch { error -> Empty<MealDetail, Never> in
                            print("Failed to fetch details for meal \(meal.id): \(error.localizedDescription)")
                            return Empty()
                        }
                })
                .collect()
            }
            .map { detailedMeals in
                detailedMeals.sorted(by: { $0.name < $1.name }) // Sort meals by name
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }, receiveValue: { sortedMeals in
                self.meals = sortedMeals
            })
            .store(in: &cancellables)
    }
}



