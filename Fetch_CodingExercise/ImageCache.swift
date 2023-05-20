//
//  ImageCache.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/17.
//

import UIKit
import Foundation

protocol ImageCacheType {
    func getImage(imageURL: URL, completionHandler: ((UIImage) -> Void)?)
    func downloadImage(imageURL: URL, completionHandler: ((UIImage) -> Void)?)
    func loadImageFromCache(imageURL: URL, completionHandler: ((UIImage) -> Void)?)
}

public class ImageCache: ImageCacheType {
    let cache = URLCache.shared
           
    func getImage(imageURL: URL, completionHandler: ((UIImage) -> Void)?) {
        let request = URLRequest(url: imageURL)
        
        if (self.cache.cachedResponse(for: request) != nil) {
            self.loadImageFromCache(imageURL: imageURL) { image in
                completionHandler?(image)
            }
        } else {
            
            self.downloadImage(imageURL: imageURL) { image in
                completionHandler?(image)
            }
        }
    }
    
    internal func downloadImage(imageURL: URL, completionHandler: ((UIImage) -> Void)?) {
        let request = URLRequest(url: imageURL)

        DispatchQueue.global(qos: .utility).async {
            
            let dataTask = URLSession.shared.dataTask(with: imageURL) {data, response, _ in
                if let data = data {
                    let cachedData = CachedURLResponse(response: response!, data: data)
                    self.cache.storeCachedResponse(cachedData, for: request)
                    completionHandler?(UIImage(data: data) ?? UIImage())
                }
            }
            dataTask.resume()
        }
    }
    
    internal func loadImageFromCache(imageURL: URL, completionHandler: ((UIImage) -> Void)?) {
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .utility).async {
            if let data = self.cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completionHandler?(image)
                }
            }
        }
    }
}
