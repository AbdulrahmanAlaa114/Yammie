//
//  Dish.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 20/02/2021.
//

import Foundation

struct Dish: Codable {
    let id, name, description, image: String?
    let calories: Int?

    var formattedCalories: String {
        "\(calories ?? 0) calories"
    }
}
