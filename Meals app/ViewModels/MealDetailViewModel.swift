//
//  MealDetailViewModel.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI
import Combine

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
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
