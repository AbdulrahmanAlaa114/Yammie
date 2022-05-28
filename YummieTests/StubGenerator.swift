//
//  StubGenerator.swift
//  MVVMPlaygroundTests
//
//  Created by Yahya Saddiq on 10/1/19.
//  Copyright © 2019 ST.Huang. All rights reserved.
//

import Foundation
@testable import Yummie

class StubGenerator {
//    func stubAllDishes() -> BaseResponse<AllDishes> {
//
//        let path = Bundle.unitTest.path(forResource: "AllDishes", ofType: "json")!
//        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        let allDishes = try! decoder.decode(BaseResponse<AllDishes>.self, from: data)
//        return allDishes
//    }
//
//    func stubDishes() -> BaseResponse<[Dish]> {
//
//        let path = Bundle.unitTest.path(forResource: "Dishs", ofType: "json")!
//        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .iso8601
//        let allDishes = try! decoder.decode(BaseResponse<[Dish]>.self, from: data)
//        return allDishes
//
//    }
    
    class func stub<M: Decodable>(fileName: String, responseClass: M.Type) -> M {
       
        let path = Bundle.unitTest.path(forResource: fileName, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let json = try! decoder.decode(responseClass.self, from: data)
        return json
        
    }


}
