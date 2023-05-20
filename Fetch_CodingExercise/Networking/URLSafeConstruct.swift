//
//  URLSafeConstruct.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/17.
//

import Foundation

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
