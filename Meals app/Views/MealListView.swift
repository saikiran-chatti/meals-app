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
                    ForEach(viewModel.desserts) { dessert in
                        if let mealID = dessert.id as String?, let _ = dessert.thumbnail {
                            NavigationLink(destination: MealDetailView(mealID: mealID)) {
                                MealRowView(dessert: dessert)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                                    .padding(.vertical, 5) // Add vertical padding to create gap between cards
                            }
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
