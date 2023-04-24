//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 20/02/2021.
//

import Kingfisher
import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryTitleLbl: UILabel!

    func setup(category: DishCategory) {
        categoryTitleLbl.text = category.name
        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }
}
