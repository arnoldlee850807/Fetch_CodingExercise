//
//  NetworkService.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/18.
//

import Foundation

class NetworkService {
    func fetch(fromURL: URL, completion: @escaping (Data) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 10.0
        sessionConfig.timeoutIntervalForResource = 30.0
        let session = URLSession(configuration: sessionConfig)

        let task = session.dataTask(with: fromURL) { data, response, error in
            guard let dataResponse = data, error == nil, let _ = response as? HTTPURLResponse else {
                print("fetch error",error?.localizedDescription ?? "Response Error")
                return
            }
            completion(dataResponse)
        }
        task.resume()
    }
    
    func decode<T: Decodable>(_ dataResponse: Data, completion: @escaping (T) -> Void) {
        do{
            let returnData =  try JSONDecoder().decode(T.self, from: dataResponse)
            completion(returnData)
        }
        catch let parsingError {
            print("Error", parsingError)
        }
    }
}
