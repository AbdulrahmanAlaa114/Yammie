//
//  Colors.swift
//  Yummie
//
//  Created by Abdulrahman on 27/05/2022.
//

import Foundation
import UIKit

extension DesignSystem {
    enum Colors: String {
        case primary = "Primary"
        case backgroundPrimary = "Background Primary"
        case backgroundSecondary = "Background Secondary"
        case buttonPrimary = "Button Primary"
        case buttonTextPrimary = "Button Text Primary"
        case textPrimary = "Text Primary"
        case textSecondary = "Text Secondary"

        var color: UIColor {
            switch self {
            default:
                return UIColor(named: rawValue) ?? .black
            }
        }
    }
}
