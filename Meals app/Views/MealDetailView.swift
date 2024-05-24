//
//  MealDetailView.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI

struct MealDetailView: View {
    let mealID: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            if let mealDetail = viewModel.mealDetail {
                VStack(alignment: .leading, spacing: 20) {
                    Text(mealDetail.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Instructions")
                        .font(.headline)
                    
                    Text(mealDetail.instructions)
                        .padding(.bottom)
                    
                    Text("Ingredients")
                        .font(.headline)
                    
                    ForEach(mealDetail.ingredients.keys.sorted(), id: \.self) { ingredient in
                        Text("\(ingredient): \(mealDetail.ingredients[ingredient]!)")
                    }
                }
                .padding()
            } else if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchMealDetail(id: mealID)
        }
        .navigationTitle("Meal Detail")
    }
}

