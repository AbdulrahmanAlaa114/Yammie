//
//  UIView+Extension.swift
//  Yummie
//
//  Created by Emmanuel Okwara on 30/01/2021.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { self.cornerRadius }
        set {
            layer.cornerRadius = newValue
        }
    }
}
