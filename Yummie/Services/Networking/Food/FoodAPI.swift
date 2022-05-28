//
//  FoodAPI.swift
//  MVVM
//
//  Created by Abdulrahman on 04/04/2022.
//

import Foundation

protocol FoodAPIProtocol {
    
    func fetchAllCategories(completion: @escaping (Result<BaseResponse<AllDishes>?, Error>) -> Void)
    func fetchCategoryDishes(info: [String: Any], completion: @escaping (Result<BaseResponse<[Dish]>?, Error>) -> Void)
    func fetchOrders(completion: @escaping (Result<BaseResponse<[Order]>?, Error>) -> Void)
    func placeOrder(info: [String: Any], completion: @escaping (Result<BaseResponse<Order>?, Error>) -> Void)
}

class FoodAPI: BaseAPI<FoodNetworking>, FoodAPIProtocol {
    
    func fetchAllCategories(completion: @escaping (Result<BaseResponse<AllDishes>?, Error>) -> Void) {
        self.fetchData(target: .fetchAllCategories, responseClass: BaseResponse<AllDishes>.self) { (result) in
            completion(result)
        }
    }
    
    func fetchCategoryDishes(info: [String: Any], completion: @escaping (Result<BaseResponse<[Dish]>?, Error>) -> Void) {
        self.fetchData(target: .fetchCategoryDishes(info: info), responseClass: BaseResponse<[Dish]>.self) { (result) in
            completion(result)
        }
    }
    
    func fetchOrders(completion: @escaping (Result<BaseResponse<[Order]>?, Error>) -> Void) {
        self.fetchData(target: .fetchOrders, responseClass: BaseResponse<[Order]>.self) { (result) in
            completion(result)
        }
    }
    
    func placeOrder(info: [String: Any], completion: @escaping (Result<BaseResponse<Order>?, Error>) -> Void) {
        self.fetchData(target: .placeOrder(info: info), responseClass: BaseResponse<Order>.self) { (result) in
            completion(result)
        }
    }

}
