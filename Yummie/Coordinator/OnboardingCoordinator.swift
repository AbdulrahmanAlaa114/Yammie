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
        
        let onboardingViewController = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        
        
        onboardingViewController.coordinator = self //remove when create view model
//        let loginViewModel = LoginViewModel()
//        loginViewModel.coordinator = self
//        loginViewVontroller.viewModel = loginViewModel
        navigationController.setViewControllers([onboardingViewController], animated: false)
        
    }
    
    func startHome(){
        
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
        
    }
    
}
