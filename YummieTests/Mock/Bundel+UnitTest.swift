//
//  Bundel+UnitTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import Foundation

extension Bundle {
    class var unitTest: Bundle {
        Bundle(for: FoodAPIMock.self)
    }
}
