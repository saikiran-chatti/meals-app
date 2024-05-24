//
//  MealRowView.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI

/// View for displaying a single row of meal information.
struct MealRowView: View {
    let meal: MealDetail
    
    var body: some View {
        HStack {
            if let thumbnail = meal.thumbnail {
                AsyncImage(url: thumbnail) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading) {
                Text(meal.name)
                    .font(.headline)
                    .foregroundColor(.black)
                if let area = meal.area, !area.isEmpty {
                    Text(area)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("No Area Info") // Debugging text
                        .font(.subheadline)
                        .foregroundColor(.red)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.vertical, 5)
        .onAppear {
            print("Meal: \(meal.name), Area: \(String(describing: meal.area))")
        }
    }
}




