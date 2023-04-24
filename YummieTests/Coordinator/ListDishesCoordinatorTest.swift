//
//  ListDishesCoordinatorTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class ListDishesCoordinatorTest: XCTestCase {
    var sut: ListDishesCoordinator!

    override func setUpWithError() throws {
        sut = ListDishesCoordinator(
            navigationController: UINavigationController(),
            category: DishCategory(id: "", name: "", image: "")
        )
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGoToDishDetail() {
        let dish = Dish(id: "", name: "", description: "", image: "", calories: 0)
        sut.goToDishDetail(dish: dish)
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
}
