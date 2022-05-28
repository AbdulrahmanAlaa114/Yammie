//
//  Bundel+UnitTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import Foundation


extension Bundle{
    public class var unitTest: Bundle{
        return Bundle(for: FoodAPIMock.self)
    }
}
