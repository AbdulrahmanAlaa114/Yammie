//
//  String+Extension.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 20/02/2021.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}



public enum State {
    case loading
    case error
    case empty
    case populated
    
}
