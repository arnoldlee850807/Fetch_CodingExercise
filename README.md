# Fetch_CodingChallenge

## Introduction

This project is for Fetch's coding challenge. Calling two endpoints

https://themealdb.com/api/json/v1/1/filter.php?c=Dessert

https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID

Structure: MVVM

## Networking Manager

### Network Service

Networking logics such as fetch and decode are being held by the network service class. 

### URL Safe Construct
In order to safely construct the URL and to reduce human errors, the urlComponents is implemented here

    class URLSafeConstruct: NSObject {
        public func constructURL(path: String, urlQueryItemArray: [URLQueryItem]) -> URL? {
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "themealdb.com"
            urlComponents.path = "/api/json/v1/1/\(path)"
            urlComponents.queryItems = urlQueryItemArray
            return urlComponents.url?.absoluteURL
        }
    }

## Image Cache

This project utilize the URLCache to achieve caching data

By checking if the image data has already been loaded to the cache, if the image existed we load the image directly from the cahce, if not we download it and cache it.

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
    
 An extension is also created to UIImageView to loadImage
 
     extension UIImageView {
        func loadImage(cache: ImageCache, imageURL: URL) {
            cache.getImage(imageURL: imageURL, completionHandler: { image in
                DispatchQueue.main.async {
                    self.image = image
                }
            })
        }
    }
    
 ## Dynamically Decode data
 
 Parse and dynamically decode all non null value from the data response
 
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
    
 ## Dessert List View
 
 This part utilized UICollectionView and image caching to accomplish showing the list of desserts
 
 ![Example](https://github.com/arnoldlee850807/Fetch_CodingExercise/blob/main/DessertListDemo.gif)
 
 ## Dessert Detail View
 
 This part utilized UITableView to accomplish, the null from the returned data has automatically been filitered
 
 ![Example](https://github.com/arnoldlee850807/Fetch_CodingExercise/blob/main/DessertDetailDemo.gif)
 
 ## Libraries
 
 Only one library is used in this project.
 
 https://github.com/SnapKit/SnapKitOne 
 
 SnapKit is used in this project to helped setting the constraints
