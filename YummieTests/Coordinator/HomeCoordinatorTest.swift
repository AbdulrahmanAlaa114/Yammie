//
//  HomeCoordinatorTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class HomeCoordinatorTest: XCTestCase {
    
    var sut :HomeCoordinator!
    
    override func setUpWithError() throws {
        sut = HomeCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoToListDishes(){
        let category = DishCategory(id: "", name: "", image: "")
        sut.goToListDishes(category: category)
        XCTAssertEqual(sut.childCoordinators.count , 1)
    }
    
    func testGoToDishDetail(){
        let dish = Dish(id: "", name: "", description: "", image: "", calories: 0)
        sut.goToDishDetail(dish: dish)
        XCTAssertEqual(sut.childCoordinators.count , 1)
    }
    
    func testGoToListOrders(){
        sut.goToListOrders()
        XCTAssertEqual(sut.childCoordinators.count , 1)
        
    }
   

}
