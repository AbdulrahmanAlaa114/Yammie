//
//  BaseViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 28/05/2022.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class BaseViewModel{
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var showAlertBehavior = BehaviorRelay<Bool>(value: false)
    
    var alertTitle = ""
    var alertMessage = ""
    var alertAction: [UIAlertAction] = []
    
    func creatAlert(alertTitle: String = "", alertMessage: String = "", alertAction:[UIAlertAction] = []){
        
        self.showAlertBehavior.accept(false)
        
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertAction = alertAction
        if alertAction.count == 0{
            self.alertAction = [UIAlertAction(title: "Ok", style: .default) { _ in
                self.showAlertBehavior.accept(false)
            }]
        }
        self.showAlertBehavior.accept(true)
    }
}

