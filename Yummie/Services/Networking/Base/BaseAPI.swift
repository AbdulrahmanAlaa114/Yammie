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
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.url, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                let error = NSError(domain: target.url, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            
            if statusCode >= 200 && statusCode <= 299 {
                // Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: target.url, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                guard let theJSONData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.url, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJSONData) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.url, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                completion(.success(responseObj))
                
            }else{
                
                switch response.result{
                    
                case .success(let payload):
                    
                    
                    let data = payload as! [String:Any]
                    
                    
                    let s = data["state"] as! Int
                    
                    
                    let error = NSError(domain: target.url, code: s, userInfo: [NSLocalizedDescriptionKey: MyErrors.errorsUr[s]])
                    
                    completion(.failure(error))
                    
                    
                    
                    break
                    
                case .failure:
                    let error = NSError(domain: target.url, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    
                    break
                    
                }
                
            }
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
