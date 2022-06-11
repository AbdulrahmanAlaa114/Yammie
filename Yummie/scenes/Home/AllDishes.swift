//
//  AllDishes.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 10/06/2021.
//

import Foundation

struct AllDishes: Codable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}