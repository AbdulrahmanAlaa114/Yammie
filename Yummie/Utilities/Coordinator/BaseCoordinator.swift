//
//  BaseCoordinator.swift
//  MVVM
//
//  Created by Abdulrahman on 04/04/2022.
//

import Foundation

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    var parantCoordinator: BaseCoordinator?

    func start() {
        fatalError("Children shoud implement 'start'")
    }

    func removeFromParant() {
        parantCoordinator?.remove(coordinator: self)
    }
}
