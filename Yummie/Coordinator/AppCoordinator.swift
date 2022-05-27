//
//  AppCoordinator.swift
//  EventesApp
//
//  Created by Mac on 01/03/2022.
//

import UIKit


final class AppCoordinator: BaseCoordinator{
    
    private let window : UIWindow
    
    init(window:UIWindow){	
        self.window = window
    }
    
    override func start() {
        
        let navigationController = UINavigationController()
        
        let onboardingCoordinator = OnboardingCoordinator(navigationController: navigationController)
        
        add(coordinator: onboardingCoordinator)
        
        onboardingCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}
