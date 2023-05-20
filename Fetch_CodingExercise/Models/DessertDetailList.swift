//
//  DessertDetailList.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import Foundation

struct DessertDetail: Decodable {
    var idMeal: String? = ""
    var strMeal: String? = ""
    var strDrinkAlternate: String? = ""
    var strCategory: String? = ""
    var strArea: String? = ""
    var strInstructions: String? = ""
    var strMealThumb: String? = ""
    var strTags: String? = ""
    var strYoutube: String? = ""
    var strSource: String? = ""
    var strImageSource: String? = ""
    var strCreativeCommonsConfirmed: String? = ""
    var dateModified: String? = ""
    var materialDictionary = [Int:IngredientAndMeasure]()
        
    enum CodingKeys: String, CodingKey{
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strSource
        case strImageSource
        case strCreativeCommonsConfirmed
        case dateModified
    }
}

struct DessertDetailList: Decodable {
    var meals: [DessertDetail] = []
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct IngredientsDetailList: Decodable {
    var meals: [DecodedIngredientData] = []
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

struct IngredientAndMeasure {
    var ingredient: String
    var measure: String
    
    init(ingredient: String = "", measure: String = "") {
        self.ingredient = ingredient
        self.measure = measure
    }
}

struct DecodedIngredientData: Decodable {
    
    var ingredientDict = [Int:IngredientAndMeasure]()
    
    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for key in container.allKeys {
            if key.stringValue.contains("strIngredient") {
                let decodedObject = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!).trimmingCharacters(in: .whitespacesAndNewlines)
                let index = Int(key.stringValue.replacingOccurrences(of: "strIngredient", with: "")) ?? 0
                if decodedObject != "" {
                    if ingredientDict.keys.contains(index) {
                        ingredientDict[index]!.ingredient = decodedObject
                    } else {
                        ingredientDict[index] = IngredientAndMeasure(ingredient: decodedObject)
                    }
                }
            }
            else if key.stringValue.contains("strMeasure") {
                let decodedObject = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!).trimmingCharacters(in: .whitespacesAndNewlines)
                let index = Int(key.stringValue.replacingOccurrences(of: "strMeasure", with: "")) ?? 0
                if decodedObject != "" {
                    if ingredientDict.keys.contains(index) {
                        ingredientDict[index]!.measure = decodedObject
                    } else {
                        ingredientDict[index] = IngredientAndMeasure(measure: decodedObject)
                    }
                }
            }
        }
    }
}
