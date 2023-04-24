//
//  ListDishesViewModelTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class ListDishesViewModelTest: XCTestCase {
    var sut: ListDishesViewModel!
    var foodAPIMock: FoodAPIMock!
    var category: DishCategory!

    override func setUpWithError() throws {
        category = DishCategory(id: "cat1", name: "cat1", image: "")
        foodAPIMock = FoodAPIMock()
        sut = ListDishesViewModel(category: category, api: foodAPIMock)
    }

    override func tearDownWithError() throws {
        category = nil
        sut = nil
        foodAPIMock = nil
    }

    func testGetData() {
        sut.getData()
        XCTAssertTrue(foodAPIMock.isCallFetchCategoryDishes)
    }

    func testGetDataSuccess() {
        sut.getData()
        foodAPIMock.fetchCategoryDishesSuccess()

        XCTAssertEqual(foodAPIMock.dishes.data?.count, 10)
    }

    func testGetDataFailure() {
        sut.getData()
        let error = AppError.serverError("hi")
        foodAPIMock.fetchCategoryDishesFailure(error: error)
        XCTAssertEqual(error.localizedDescription, sut.alertMessage)
    }

    func testGoTo() {
        let dish = Dish(id: "", name: "", description: "", image: "", calories: 0)
        sut.coordinator?.goToDishDetail(dish: dish)
    }

    func testSelectedDish() {
        let dish = Dish(id: "", name: "", description: "", image: "", calories: 0)

        sut.selected(dish: dish)
    }
}
