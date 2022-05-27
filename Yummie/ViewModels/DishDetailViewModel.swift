//
//  DishDetailViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxSwift
import RxRelay

class DishDetailViewModel{
    
    
    var alertTitle = ""
    var alertMessage = ""
    var alertAction: [UIAlertAction] = []
    
    var showAlertBehavior = BehaviorRelay<Bool>(value: false)
    
    let dish: Dish
    var coordinator: DishDetailCoordinator?
    var nameBehavior   = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var isPlaceOrderButtonEnapled: Observable<Bool> {
        return nameBehavior.asObservable().map { (name) -> Bool in
            let isNameEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return !isNameEmpty
        }
    }
    
    init(dish: Dish){
        self.dish = dish
    }
    
    func creatAlert(alertTitle: String, alertMessage: String, alertAction:[UIAlertAction]){
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertAction = alertAction
        self.showAlertBehavior.accept(true)
    }
    
    func placingOrder(){
        
        print(nameBehavior.value)
        
        let api: FoodAPIProtocol = FoodAPI()
        loadingBehavior.accept(true)
        let info = [
            "dishId":"\(dish.id ?? "")",
            "name": nameBehavior.value
        ]
        
        api.placeOrder(info: info) { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case .success(_):
                
                self.creatAlert(alertTitle: "Success", alertMessage: "Your order has been received. 👨🏼‍🍳", alertAction: [
                    UIAlertAction(title: "Ok", style: .default, handler: { _ in
                        print("done")
                        self.showAlertBehavior.accept(false)
                    })
                ])
                
                print("Your order has been received. 👨🏼‍🍳")
                self.loadingBehavior.accept(false)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
                
            }
        }
         
    }
    
    deinit{
        coordinator?.removeFromParant()
        print("deinit DishDetailViewModel")
    }
}
