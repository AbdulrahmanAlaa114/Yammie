//
//  DishDetailViewModelTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class DishDetailViewModelTest: XCTestCase {
    
    var sut: DishDetailViewModel!
    var foodAPIMock: FoodAPIMock!
    var dish: Dish!
    
    override func setUpWithError() throws {
        
        foodAPIMock = FoodAPIMock()
        dish = Dish(id: "item2", name: "Abdo", description: "hi hi", image: "", calories: 125)
        sut = DishDetailViewModel(dish: dish, api: foodAPIMock)
        
    }
    
    override func tearDownWithError() throws {
        
        sut = nil
        foodAPIMock = nil
        dish = nil
        
    }
    
    
    func testPlacingOrder(){
        
        sut.placingOrder()
        XCTAssertTrue(foodAPIMock.isCallPlaceOrder)
        
    }
    
    func testPlacingOrderSuccess(){
        
        sut.placingOrder()
        foodAPIMock.fetchPlaceOrderSuccess()
        
        XCTAssertEqual(foodAPIMock.placeOrder.status, 200)
        
    }
    
    
    func testPlacingOrderFailure(){
        
        sut.placingOrder()
        let error = AppError.errorDecoding
        foodAPIMock.fetchPlaceOrderFailure(error: error)
        XCTAssertEqual(error.localizedDescription, sut.alertMessage)
    
    }
    
    
}
