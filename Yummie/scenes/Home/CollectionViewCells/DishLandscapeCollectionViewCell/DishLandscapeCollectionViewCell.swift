//
//  DishLandscapeCollectionViewCell.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 20/02/2021.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    func setup(dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
    }
}
