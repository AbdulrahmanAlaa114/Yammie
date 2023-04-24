//
//  DishLandscapeCollectionViewCell.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 20/02/2021.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var caloriesLbl: UILabel!

    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }
}
