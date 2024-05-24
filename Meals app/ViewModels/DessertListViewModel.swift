//
//  DesserListViewModel.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI
import Combine

struct IdentifiableError: Identifiable {
    let id = UUID() // Ensures each instance has a unique identifier
    let message: String
}

class DessertListViewModel: ObservableObject {
    @Published var desserts: [Dessert] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchDesserts() {
        isLoading = true
        errorMessage = nil
        APIService.shared.fetchDesserts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = IdentifiableError(message: error.localizedDescription)
                }
            }, receiveValue: { desserts in
                self.desserts = desserts.filter { $0.id != "" && $0.name != "" && $0.thumbnail != nil }
            })
            .store(in: &cancellables)
    }
}
