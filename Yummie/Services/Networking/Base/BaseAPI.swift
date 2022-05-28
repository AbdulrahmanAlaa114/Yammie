//
//  BaseAPI.swift
//  Banana
//
//  Created by Abdulrahman Alaa on 8/1/20.
//  Copyright © 2020 Abdulrahman Alaa. All rights reserved.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, Error>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.url, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
           
//            print(try? response.result.get())
//            guard let statusCode = response.response?.statusCode else {
//                // ADD Custom Error
//                completion(.failure(AppError.statusCode))
//                return
//            }
            
//            if statusCode >= 200 && statusCode <= 299 {
               
                guard let jsonResponse = try? response.result.get() else {
                    completion(.failure(AppError.unknownError))
                    return
                }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    completion(.failure(AppError.unknownError))
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                
                    completion(.failure(AppError.errorDecoding))
                    return
                }
            
                completion(.success(responseObj))
                
                
                
//            }else{
//
//
//
//            }
        }
    }
    
    
    private func buildParams(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    
}
