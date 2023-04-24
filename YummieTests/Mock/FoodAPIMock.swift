//
//  FoodAPIMock.swift
//  YummieTests
//
//  Created by Abdulrahman on 27/05/2022.
//

import Foundation
@testable import Yummie

class FoodAPIMock: FoodAPIProtocol {
    var isCallfetchAllCategories = false
    var completeClosureFetchAllCategories: ((Result<BaseResponse<AllDishes>?, Error>) -> Void)!
    var allDishes: BaseResponse<AllDishes>!

    var isCallFetchCategoryDishes = false
    var completeClosureFetchCategoryDishes: ((Result<BaseResponse<[Dish]>?, Error>) -> Void)!
    var dishes: BaseResponse<[Dish]>!

    var isCallfetchOrders = false
    var completeClosureFetchOrders: ((Result<BaseResponse<[Order]>?, Error>) -> Void)!
    var orders: BaseResponse<[Order]>!

    var isCallPlaceOrder = false
    var completeClosurePlaceOrder: ((Result<BaseResponse<Order>?, Error>) -> Void)!
    var placeOrder: BaseResponse<Order>!

    func fetchAllCategories(completion: @escaping (Result<BaseResponse<AllDishes>?, Error>) -> Void) {
        isCallfetchAllCategories = true
        completeClosureFetchAllCategories = completion
    }

    func fetchAllCategoriesSuccess() {
        let all = StubGenerator.stub(fileName: "AllDishes", responseClass: BaseResponse<AllDishes>.self)
        allDishes = all
        completeClosureFetchAllCategories(.success(all))
    }

    func fetchAllCategoriesFailure(error: Error) {
        completeClosureFetchAllCategories(.failure(error))
    }

    func fetchCategoryDishes(
        info _: [String: Any],
        completion: @escaping (Result<BaseResponse<[Dish]>?, Error>) -> Void
    ) {
        isCallFetchCategoryDishes = true
        completeClosureFetchCategoryDishes = completion
    }

    func fetchCategoryDishesSuccess() {
        let all = StubGenerator.stub(fileName: "Dishes", responseClass: BaseResponse<[Dish]>.self)
        dishes = all
        completeClosureFetchCategoryDishes(.success(all))
    }

    func fetchCategoryDishesFailure(error: Error) {
        completeClosureFetchCategoryDishes(.failure(error))
    }

    func fetchOrders(completion: @escaping (Result<BaseResponse<[Order]>?, Error>) -> Void) {
        isCallfetchOrders = true
        completeClosureFetchOrders = completion
    }

    func fetchOrdersSuccess() {
        let all = StubGenerator.stub(fileName: "Orders", responseClass: BaseResponse<[Order]>.self)
        orders = all
        completeClosureFetchOrders(.success(all))
    }

    func fetchOrdersFailure(error: Error) {
        completeClosureFetchOrders(.failure(error))
    }

    func placeOrder(info _: [String: Any], completion: @escaping (Result<BaseResponse<Order>?, Error>) -> Void) {
        isCallPlaceOrder = true
        completeClosurePlaceOrder = completion
    }

    func fetchPlaceOrderSuccess() {
        let all = StubGenerator.stub(fileName: "PlaceOrder", responseClass: BaseResponse<Order>.self)
        placeOrder = all
        completeClosurePlaceOrder(.success(all))
    }

    func fetchPlaceOrderFailure(error: Error) {
        completeClosurePlaceOrder(.failure(error))
    }
}
