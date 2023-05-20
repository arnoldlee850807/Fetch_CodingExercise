//
//  DessertDetailViewModel.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import UIKit
import Foundation

class DessertDetailViewModel {
    var dessertImage: UIImage = UIImage()
    var dessertName: String = ""
    var dessertId: String = ""
    
    var dessertDetailList: ObservableObject<DessertDetailList?> = ObservableObject(nil)
    
    private var ingredientsDetailList = IngredientsDetailList() {
        didSet {
            guard ingredientsDetailList.meals.first?.materialDict != nil else { return }
            self.dessertDetailList.value?.meals[0].materialDictionary = ingredientsDetailList.meals.first!.materialDict
        }
    }
    
    init(dessertImage: UIImage = UIImage(), dessertName: String = "", dessertId: String = "") {
        self.dessertImage = dessertImage
        self.dessertName = dessertName
        self.dessertId = dessertId
    }
    
    func fetchDessertData() {
        let urlSafeConstruct = URLSafeConstruct()
        guard let getDessertURL = urlSafeConstruct.constructURL(path: "lookup.php", urlQueryItemArray: [URLQueryItem(name: "i", value: "\(dessertId)")]) else {
            print("getDessertURL error")
            return
        }
        let network = NetworkService()
        
        network.fetch(fromURL: getDessertURL) { fetchedResponse in
            network.decode(fetchedResponse) { decodedFetchedResponse1 in
                self.dessertDetailList.value = decodedFetchedResponse1
            }
            network.decode(fetchedResponse) { decodedFetchedResponse2 in
                self.ingredientsDetailList = decodedFetchedResponse2
            }
        }
        
    }
}
