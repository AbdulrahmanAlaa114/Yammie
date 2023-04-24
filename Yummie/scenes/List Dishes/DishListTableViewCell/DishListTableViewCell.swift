//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 21/02/2021.
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!

    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
    }

    func setup(order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        titleLbl.text = order.dish?.name
        descriptionLbl.text = order.name
    }
}
