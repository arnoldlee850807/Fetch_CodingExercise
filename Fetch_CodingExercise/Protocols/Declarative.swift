//
//  Declarative.swift
//  Fetch_CodingExercise
//
//  Created by Arnold Lee on 2023/5/17.
//

import Foundation

protocol Declarative: AnyObject {
    init()
}

extension Declarative {
    init(configureHandler: (Self) -> Void) {
        self.init()
        configureHandler(self)
    }
}

extension NSObject: Declarative {}
