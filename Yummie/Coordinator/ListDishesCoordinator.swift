//
//  ListDishesCoordinator.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import UIKit

final class ListDishesCoordinator: BaseCoordinator{
    
    let navigationController: UINavigationController
    let category: DishCategory
    
    init(navigationController: UINavigationController, category: DishCategory){
        
        self.navigationController = navigationController
        self.category = category
        
    }
    
    override func start() {
        
        let listDishesViewContrroler = ListDishesViewController()
        let viewModel = ListDishesViewModel(category: category)
        viewModel.coordinator = self
        listDishesViewContrroler.viewModel = viewModel
        navigationController.pushViewController(listDishesViewContrroler, animated: true)
//        navigationController.setViewControllers([listDishesViewContrroler], animated: true)
        
    }
    
    func goToDishDetail(dish: Dish){
        
        let coordinator = DishDetailCoordinator(navigationController: navigationController, dish: dish)
        add(coordinator: coordinator)
        coordinator.parantCoordinator = self 
        coordinator.start()
        
    }
    
    deinit{
        print("deinit ListDishesCoordinator")
    }
    
    
}
