//
//  HomeCoordinator.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit


final class HomeCoordinator : BaseCoordinator{
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    override func start() {
        
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        
        
//        let loginViewModel = LoginViewModel()
//        loginViewModel.coordinator = self
//        loginViewVontroller.viewModel = loginViewModel
        navigationController.setViewControllers([homeViewController], animated: false)
        
    }
}
