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
    
    func testFetchAllCategoriesSuccess() {
        
        let expect = XCTestExpectation(description: "callback1")

        sut?.fetchAllCategories(completion: { result in
            
            if let response = try? result.get() {
                expect.fulfill()
                XCTAssertEqual(response.status, 200)
            }
            
        })
        
        wait(for: [expect], timeout: 20)
        
    }
    
    func testFetchCategoryDishesSuccess() {
        
        let expect = XCTestExpectation(description: "callback2")

        sut?.fetchCategoryDishes(info: ["categoryId": "cat1"], completion: { result in
            
            if let response = try? result.get() {
                expect.fulfill()
                XCTAssertEqual(response.status, 200)
            }
        })
        
        wait(for: [expect], timeout: 10)
        
    }
    
    func testFetchOrders() {
        
        let expect = XCTestExpectation(description: "callback3")

        sut?.fetchOrders(completion: { result in
            
            if let response = try? result.get() {
                expect.fulfill()
                
                XCTAssertEqual(response.status, 200)
            }
        })
        
        wait(for: [expect], timeout: 10)
    }
    
    func testPlaceOrder() {
        
        let expect = XCTestExpectation(description: "callback3")

        let info = [
            "name": "abdo",
            "dishId": "item2"
        ]
        sut?.placeOrder(info: info, completion: { result in
            
            if let response = try? result.get() {
                expect.fulfill()
                
                XCTAssertEqual(response.status, 201)
            }
        })
        
        wait(for: [expect], timeout: 10)
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }

}
