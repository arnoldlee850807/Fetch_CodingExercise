//
//  DessertListViewModel.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import Foundation

class DessertListViewModel {
    var dessertList: ObservableObject<DessertList?> = ObservableObject(nil)
    
    func fetchDessertListData() {
        let urlSafeConstruct = URLSafeConstruct()
        guard let getDessertListURL = urlSafeConstruct.constructURL(path: "filter.php", urlQueryItemArray: [URLQueryItem(name: "c", value: "Dessert")]) else {
            print("getDessertListURL error")
            return
        }
        let network = NetworkService()
        
        network.fetch(fromURL: getDessertListURL) { fetchedResponse in
            network.decode(fetchedResponse) { decodedFetchedResponse in
                self.dessertList.value = decodedFetchedResponse
            }
        }
    }
}
