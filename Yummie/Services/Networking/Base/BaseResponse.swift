//
//  BaseResponse.swift
//  Banana
//
//  Created by Abdulrahman Alaa on 8/1/20.
//  Copyright © 2020 Abdulrahman Alaa. All rights reserved.
//

import Foundation


class BaseResponse<T: Codable>: Codable {
   
    let message: String?
    let data: T?
    let status:Int?
  
}





