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
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Text(dessert.name)
                .font(.headline)
        }
    }
}

