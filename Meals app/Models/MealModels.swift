//
//  MealModels.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//

import Foundation

struct DessertListResponse: Codable {
    let meals: [Dessert]
}

struct Dessert: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnail: URL
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Codable, Identifiable {
    let id: String
    let name: String
    let instructions: String
    let ingredients: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case ingredients
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        
        var ingredients = [String: String]()
        for i in 1...20 {
            let ingredientKey = CodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = CodingKeys(stringValue: "strMeasure\(i)")!
            let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey) ?? ""
            let measure = try container.decodeIfPresent(String.self, forKey: measureKey) ?? ""
            if !ingredient.isEmpty {
                ingredients[ingredient] = measure
            }
        }
        self.ingredients = ingredients
    }
}
