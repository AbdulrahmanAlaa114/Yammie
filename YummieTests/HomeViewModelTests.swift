//
//  HomeViewModelTests.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class HomeViewModelTests: XCTestCase {

    
    var sut:HomeViewModel!
    var foodAPIMock: FoodAPIMock!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        foodAPIMock = FoodAPIMock()
        sut = HomeViewModel(api: foodAPIMock)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testGetData(){
        
        sut.getData()
        XCTAssertTrue(foodAPIMock.isCallfetchAllCategories)
        
    }
    
    func testGetDataSuccess(){
        
        sut.getData()
        foodAPIMock.fetchAllCategoriesSuccess()
        
        XCTAssertEqual(foodAPIMock.allDishes.data?.categories?.count, 4)
        XCTAssertEqual(foodAPIMock.allDishes.data?.populars?.count, 5)
        XCTAssertEqual(foodAPIMock.allDishes.data?.specials?.count, 2)
    }
    
    
    func testGetDataFailure(){
        
        sut.getData()
        let error = AppError.unknownError
        foodAPIMock.fetchAllCategoriesFailure(error: error)
        XCTAssertEqual(error.localizedDescription, sut.alertMessage)
    
    }
    

}
