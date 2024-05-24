//
//  MealDetailViewModel.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI
import Combine

/// ViewModel for managing detailed information about a specific meal.
class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    /// Fetches the detailed information for a specific meal by its ID.
    func fetchMealDetail(id: String) {
        isLoading = true
        errorMessage = nil
        APIService.shared.fetchMealDetail(by: id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { mealDetail in
                self.mealDetail = mealDetail
            })
            .store(in: &cancellables)
    }
}
