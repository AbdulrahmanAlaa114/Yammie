//
//  HomeCoordinator.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit

final class HomeCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.setViewControllers([viewController], animated: false)
    }

    func goToListDishes(category: DishCategory) {
        let coordinator = ListDishesCoordinator(navigationController: navigationController, category: category)
        coordinator.parantCoordinator = self
        add(coordinator: coordinator)
        coordinator.start()
    }

    func goToDishDetail(dish: Dish) {
        let coordinator = DishDetailCoordinator(navigationController: navigationController, dish: dish)
        add(coordinator: coordinator)
        coordinator.parantCoordinator = self
        coordinator.start()
    }

    func goToListOrders() {
        let coordinator = ListOrdersCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        coordinator.parantCoordinator = self
        coordinator.start()
    }
}
