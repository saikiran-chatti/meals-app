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
            List(viewModel.desserts) { dessert in
                if let mealID = dessert.id as String?, let _ = dessert.thumbnail {
                    NavigationLink(destination: MealDetailView(mealID: mealID)) {
                        MealRowView(dessert: dessert)
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                viewModel.fetchDesserts()
            }
            .alert(item: $viewModel.errorMessage) { error in
                Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
            }
        }
    }
}


