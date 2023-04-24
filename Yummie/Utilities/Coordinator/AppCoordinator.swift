//
//  AppCoordinator.swift
//  EventesApp
//
//  Created by Mac on 01/03/2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let navigationController = UINavigationController()

        if UserDefaults.standard.hasOnboarded {
            let coordinator = HomeCoordinator(navigationController: navigationController)
            add(coordinator: coordinator)
            coordinator.start()
        } else {
            let coordinator = OnboardingCoordinator(navigationController: navigationController)
            add(coordinator: coordinator)
            coordinator.start()
        }
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
