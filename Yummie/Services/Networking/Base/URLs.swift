//
//  EndPoints.swift
//  Banana
//
//  Created by Abdulrahman Alaa on 8/1/20.
//  Copyright © 2020 Abdulrahman Alaa. All rights reserved.
//

import Foundation

struct URLs {
    
    // MARK: - The BasicPath
    
    static let baseUrl = "https://yummie.glitch.me"

    //MARK: - Complete Path
    
    static let fetchAllCategories   = baseUrl + "/dish-categories"
    static let placeOrder           = baseUrl + "/orders/"
    static let fetchCategoryDishes  = baseUrl + "/dishes/"
    static let fetchOrders          = baseUrl + "/orders"
    
}
