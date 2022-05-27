//
//  ListOrdersCoordinator.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import UIKit

final class ListOrdersCoordinator: BaseCoordinator{
    
    
    let navigationController: UINavigationController
        
    init(navigationController: UINavigationController){
        
        self.navigationController = navigationController
        
    }
    
    override func start() {
        
        let viewContrroler = ListOrdersViewController()
        let viewModel = ListOrdersViewModel()
        viewModel.coordinator = self
        viewContrroler.viewModel = viewModel
        navigationController.pushViewController(viewContrroler, animated: true)
    }
    
    func goToDishDetail(dish: Dish){
        
        let coordinator = DishDetailCoordinator(navigationController: navigationController, dish: dish)
        coordinator.parantCoordinator = self
        add(coordinator: coordinator)
        coordinator.start()
        
    }
    
    deinit{
        print("deinit ListOrdersCoordinator")
    }
    
    
}
