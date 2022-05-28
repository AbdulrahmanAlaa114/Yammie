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
   
    var completeClosure: ((Result<BaseResponse<AllDishes>?, Error>) -> Void)!
    var allDishes: BaseResponse<AllDishes>!
    func fetchAllCategories(completion: @escaping (Result<BaseResponse<AllDishes>?, Error>) -> Void) {
        
        isCallfetchAllCategories = true
        self.completeClosure = completion

    }
    
    func fetchAllCategoriesSuccess(){
        
        let all = StubGenerator().stubAllDishes()
        self.allDishes = all
        completeClosure(.success(all))
        
    }
    
    func fetchAllCategoriesFailure(error: Error){
        
        completeClosure(.failure(error))
        
    }
    
    func fetchCategoryDishes(info: [String : Any], completion: @escaping (Result<BaseResponse<[Dish]>?, Error>) -> Void) {
        
    }
    
    func fetchOrders(completion: @escaping (Result<BaseResponse<[Order]>?, Error>) -> Void) {
        
    }
    
    func placeOrder(info: [String : Any], completion: @escaping (Result<BaseResponse<Order>?, Error>) -> Void) {
        
    }
    
    
    
    
}
