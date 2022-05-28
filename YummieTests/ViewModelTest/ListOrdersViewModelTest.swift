//
//  ListOrdersViewModelTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class ListOrdersViewModelTest: XCTestCase {
    
    var sut: ListOrdersViewModel!
    var foodAPIMock: FoodAPIMock!
    
    override func setUpWithError() throws {
        
        foodAPIMock = FoodAPIMock()
        sut = ListOrdersViewModel(api: foodAPIMock)
        
    }

    override func tearDownWithError() throws {
       foodAPIMock = nil
        sut = nil
    }

    func testGetData() {
        
        sut.getData()
        XCTAssertTrue(foodAPIMock.isCallfetchOrders)
        
    }
    
    func testGetDataSuccess() {
        
        sut.getData()
        foodAPIMock.fetchOrdersSuccess()
        
        XCTAssertEqual(foodAPIMock.orders.data?.count, 4)
        
    }
    
    func testGetDataFailure() {
        
        sut.getData()
        let error = AppError.invalidUrl
        foodAPIMock.fetchOrdersFailure(error: error)
        XCTAssertEqual(error.localizedDescription, sut.alertMessage)
    
    }
    
    func testSelectedDish() {
        let dish = Dish(id: "", name: "", description: "", image: "", calories: 0)

        sut.selected(dish: dish)
    }
     
}
