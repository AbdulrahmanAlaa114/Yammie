//
//  TableView+Extension.swift
//  Yummie
//
//  Created by Abdulrahman on 28/05/2022.
//

import UIKit

extension UITableView {
    func registerNib<Cell: UITableViewCell>(cell _: Cell.Type) {
        let nibName = Cell.identifier
        register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

extension UITableViewCell: Reusable {}

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        String(describing: self)
    }
}
