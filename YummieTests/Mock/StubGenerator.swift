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
    
    class func stub<M: Decodable>(fileName: String, responseClass: M.Type) -> M? {
        
        guard let path = Bundle.unitTest.path(forResource: fileName, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let json = try? decoder.decode(responseClass.self, from: data)
        return json
        
    }
    
}
