//
//  DishPortraitCollectionViewCell.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 20/02/2021.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var caloriesLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!

    func setup(dish: Dish) {
        titleLbl.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLbl.text = dish.formattedCalories
        descriptionLbl.text = dish.description
    }
}
