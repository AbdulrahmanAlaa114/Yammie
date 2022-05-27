//
//  BaseCoordinator.swift
//  MVVM
//
//  Created by Abdulrahman on 04/04/2022.
//

import Foundation

class BaseCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    
    func start(){
        fatalError("Children shoud implement 'start'")
    }
}
