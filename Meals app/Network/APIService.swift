//
//  APIService.swift
//  Meals app
//
//  Created by Kiran Chatti on 5/23/24.
//
import Foundation
import Combine

/// Singleton service for handling API requests.
class APIService {
    static let shared = APIService()
    private init() {}
    
    private let baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    /// Fetches the list of desserts.
    func fetchDesserts() -> AnyPublisher<[Dessert], Error> {
        let url = URL(string: "\(baseURL)filter.php?c=Dessert")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DessertListResponse.self, decoder: JSONDecoder())
            .map { $0.meals.filter { $0.id != "" && $0.name != "" } }
            .eraseToAnyPublisher()
    }
    
    /// Fetches the detailed information for a specific meal by its ID.
    func fetchMealDetail(by id: String) -> AnyPublisher<MealDetail, Error> {
        let url = URL(string: "\(baseURL)lookup.php?i=\(id)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MealDetailResponse.self, decoder: JSONDecoder())
            .compactMap { $0.meals.first }
            .eraseToAnyPublisher()
    }
}

