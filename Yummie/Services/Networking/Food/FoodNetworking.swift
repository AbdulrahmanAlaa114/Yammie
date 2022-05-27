//
//  FoodNetworking.swift
//  MVVM
//
//  Created by Abdulrahman on 04/04/2022.
//

import Foundation
import Alamofire

enum FoodNetworking {
    
    case fetchAllCategories
    case placeOrder(info: [String:Any])
    case fetchCategoryDishes(info: [String:Any])
    case fetchOrders
}


extension FoodNetworking: TargetType {
    
    var url: String {
        
        switch self {
       
            
        case .fetchAllCategories:
            return URLs.fetchAllCategories
        case .placeOrder(info: let info):
            return URLs.placeOrder + "\(info["dishId"] as! String)"
        case .fetchCategoryDishes(info: let info):
            return URLs.fetchCategoryDishes + "\(info["categoryId"] as! String)"
        case .fetchOrders:
            return URLs.fetchOrders
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        
        
            
        case .fetchAllCategories:
            return .get
        case .placeOrder:
            return .post
        case .fetchCategoryDishes:
            return .get
        case .fetchOrders:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        
        case .fetchAllCategories:
            return .requestPlain
        case .placeOrder(info: let info):
        
            return .requestParameters(parameters: info, encoding: JSONEncoding.default)
        case .fetchCategoryDishes:
            return .requestPlain
        case .fetchOrders:
            return .requestPlain
        }
        
    }
    
    var headers: [String: String]? {
        switch self {

        default:
            return [:]
            
            
        }
    }
}

