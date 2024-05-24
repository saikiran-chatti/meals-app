//
//  MealListView.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = DessertListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(viewModel.meals) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.id)) {
                            MealRowView(meal: meal)
                                .padding(.horizontal)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchDesserts()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

