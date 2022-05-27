//
//  MoviesNetworking.swift
//  MVVM
//
//  Created by Abdulrahman on 04/04/2022.
//

import Foundation
import Alamofire

enum MoviesNetworking {
    
    case getMoviesList
    
}


extension MoviesNetworking: TargetType {
    
    var url: String {
        
        switch self {
        case .getMoviesList:
            
            return URLs.getMovies
            
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        
        case .getMoviesList:
            return .get
            
        }
    }
    
    var task: Task {
        switch self {
        
        
        case .getMoviesList:
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
