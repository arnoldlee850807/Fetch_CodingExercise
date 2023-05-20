//
//  DessertList.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import Foundation

struct Dessert: Codable {
    var idMeal: String? = ""
    var strMealThumb: String? = ""
    var strMeal: String? = ""
}

struct DessertList: Codable {
    var meals: [Dessert] = []
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}
