//
//  Order.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 21/02/2021.
//

import Foundation

struct Order: Codable {
    let id: String?
    let name: String?
    let dish: Dish?
}
