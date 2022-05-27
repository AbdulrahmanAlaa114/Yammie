//
//  DishDetailCoordinator.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import UIKit

final class DishDetailCoordinator: BaseCoordinator{
    
    let navigationController: UINavigationController
    let dish: Dish
    
    
    
    init(navigationController: UINavigationController, dish: Dish){
        
        self.navigationController = navigationController
        self.dish = dish
        
    }
    
    override func start() {
        
        let viewController = DishDetailViewController()
        let viewModel = DishDetailViewModel(dish: dish)
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
//    func remove(){
//        parantCoordinator?.remove(coordinator: self)
//    }
    
    deinit{
        print("deinit DishDetailCoordinator")
    }
    
}
