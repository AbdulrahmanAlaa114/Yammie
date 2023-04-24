//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var slideImageView: UIImageView!
    @IBOutlet var slideTitleLbl: UILabel!
    @IBOutlet var slideDescriptionLbl: UILabel!

    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLbl.text = slide.title
        slideDescriptionLbl.text = slide.description
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
