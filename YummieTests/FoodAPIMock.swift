//
//  FoodAPIMock.swift
//  YummieTests
//
//  Created by Abdulrahman on 27/05/2022.
//

import Foundation
@testable import Yummie


class FoodAPIMock: FoodAPIProtocol{
    
    
    var isCallfetchAllCategories = false
    var completeClosureFetchAllCategories: ((Result<BaseResponse<AllDishes>?, Error>) -> Void)!
    var allDishes: BaseResponse<AllDishes>!
    
    var isCallFetchCategoryDishes = false
    var completeClosureFetchCategoryDishes: ((Result<BaseResponse<[Dish]>?, Error>) -> Void)!
    var dishes: BaseResponse<[Dish]>!
    
//    var isCallfetchAllCategories = false
//    var completeClosureFetchAllCategories: ((Result<BaseResponse<AllDishes>?, Error>) -> Void)!
//    var allDishes: BaseResponse<AllDishes>!
//
//    var isCallfetchAllCategories = false
//    var completeClosureFetchAllCategories: ((Result<BaseResponse<AllDishes>?, Error>) -> Void)!
//    var allDishes: BaseResponse<AllDishes>!
    
    func fetchAllCategories(completion: @escaping (Result<BaseResponse<AllDishes>?, Error>) -> Void) {
        
        isCallfetchAllCategories = true
        self.completeClosureFetchAllCategories = completion

    }
    
    func fetchAllCategoriesSuccess(){
        
        let all = StubGenerator.stub(fileName: "AllDishes", responseClass: BaseResponse<AllDishes>.self)
        self.allDishes = all
        completeClosureFetchAllCategories(.success(all))
        
    }
    
    func fetchAllCategoriesFailure(error: Error){
        
        completeClosureFetchAllCategories(.failure(error))
        
    }
    
    func fetchCategoryDishes(info: [String : Any], completion: @escaping (Result<BaseResponse<[Dish]>?, Error>) -> Void) {
        isCallFetchCategoryDishes = true
        self.completeClosureFetchCategoryDishes = completion
    }
    
    
    func fetchCategoryDishesSuccess(){
        
        let all = StubGenerator.stub(fileName: "Dishes", responseClass: BaseResponse<[Dish]>.self)
        self.dishes = all
        completeClosureFetchCategoryDishes(.success(all))
        
    }
    
    func fetchCategoryDishesFailure(error: Error){
        
        completeClosureFetchCategoryDishes(.failure(error))
        
    }
    
    
    
    func fetchOrders(completion: @escaping (Result<BaseResponse<[Order]>?, Error>) -> Void) {
        
    }
    
    func placeOrder(info: [String : Any], completion: @escaping (Result<BaseResponse<Order>?, Error>) -> Void) {
        
    }
    
    
    
    
}
