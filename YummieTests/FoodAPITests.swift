//
//  FoodAPITests.swift
//  YummieTests
//
//  Created by Abdulrahman on 27/05/2022.
//

import XCTest
@testable import Yummie


class FoodAPITests: XCTestCase {

    var sut: FoodAPI?
    
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = FoodAPI()
    }
    
    func testFetchAllCategoriesSuccess(){
        
        let expect = XCTestExpectation(description: "callback1")
//        var responseError: Error?
//        var responseSuccess: BaseResponse<AllDishes>?
        
        sut?.fetchAllCategories(completion: { result in
            
            if let r = try? result.get()?.data{
                expect.fulfill()
                XCTAssertEqual(r.categories?.count, 5)
                XCTAssertEqual(r.populars?.count, 5)
                XCTAssertEqual(r.specials?.count, 2)
            }
            
        })
        
        wait(for: [expect], timeout: 10)
        
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

  

}
