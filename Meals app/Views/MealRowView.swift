//
//  MealRowView.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation
import SwiftUI

struct MealRowView: View {
    let dessert: Dessert
    
    var body: some View {
        HStack {
            if let thumbnail = dessert.thumbnail {
                AsyncImage(url: thumbnail) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .clipShape(Circle()) // Change to Circle to match the image style
                .padding(.trailing, 10)
            }
            
            VStack(alignment: .leading) {
                Text(dessert.name)
                    .font(.headline)
                if let area = dessert.area, !area.isEmpty {
                    Text(area) // Display the area
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
//        .cornerRadius(10)
//        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        .padding(.vertical, 5) // Add vertical padding to create gap between cards
        .onAppear {
            print("Dessert: \(dessert.name), Area: \(String(describing: dessert.area))")
        }
    }
}



