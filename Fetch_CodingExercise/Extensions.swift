//
//  Extensions.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/17.
//

import UIKit
import Foundation

extension String {
    var numbersContained: [Int] {
        let numbersInString = self.components(separatedBy: .decimalDigits.inverted).filter { !$0.isEmpty }
        return numbersInString.compactMap { Int($0) }
    }
}

extension UIImageView {
    func loadImage(imageURL: URL) {
        let imageCache = ImageCache()
        imageCache.getImage(imageURL: imageURL, completionHandler: { image in
            DispatchQueue.main.async {
                self.image = image
            }
        })
    }
}
