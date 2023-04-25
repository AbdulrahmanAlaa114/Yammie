//
//  BaseAPI.swift
//  Banana
//
//  Created by Abdulrahman Alaa on 8/1/20.
//  Copyright © 2020 Abdulrahman Alaa. All rights reserved.
//

import Alamofire
import Foundation

class BaseAPI<T: TargetType> {
    func fetchData<M: Decodable>(
        target: T,
        responseClass _: M.Type,
        completion: @escaping (Result<M?, Error>) -> Void
    ) {
        guard Reachability()?.connection != Reachability.Connection.none else {
            completion(.failure(AppError.noInternetConnection))
            return
        }
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        AF.request(target.url, method: method, parameters: params.0, encoding: params.1, headers: headers)
            .responseData { response in
                switch response.result {
                case let .success(result):
                    guard let responseObj = try? JSONDecoder().decode(M.self, from: result) else {
                        completion(.failure(AppError.errorDecoding))
                        return
                    }
                    completion(.success(responseObj))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }

    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case let .requestParameters(parameters: parameters, encoding: encoding):
            return (parameters, encoding)
        }
    }
}
