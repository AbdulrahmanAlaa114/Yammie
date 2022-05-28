//
//  OnboardingCoordinator.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit

final class OnboardingCoordinator : BaseCoordinator{
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let viewController = OnboardingViewController()
        let viewModel = OnboardingViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func startHome(){
        
        let coordinator = HomeCoordinator(navigationController: navigationController)
        add(coordinator: coordinator)
        coordinator.start()
        
    }
    
//    deinit{
//        print("deinit OnboardingCoordinator")
//    }
    
}
