//
//  BaseViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 28/05/2022.
//

import Foundation
import RxRelay
import RxSwift
import UIKit

class BaseViewModel {
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var showAlertBehavior = BehaviorRelay<Bool>(value: false)
    var alertTitle = ""
    var alertMessage = ""
    var alertAction: [UIAlertAction] = []

    func creatAlert(alertTitle: String = "", alertMessage: String = "", alertAction: [UIAlertAction] = []) {
        showAlertBehavior.accept(false)
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertAction = alertAction
        if alertAction.isEmpty {
            self.alertAction = [
                UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
                    guard let self = self else { return }
                    self.showAlertBehavior.accept(false)
                }
            ]
        }
        showAlertBehavior.accept(true)
    }
}
