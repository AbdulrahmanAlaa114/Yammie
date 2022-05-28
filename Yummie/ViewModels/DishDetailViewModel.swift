//
//  DishDetailViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxSwift
import RxRelay

class DishDetailViewModel: BaseViewModel{
    
    let dish: Dish
    var coordinator: DishDetailCoordinator?
    var nameBehavior   = BehaviorRelay<String>(value: "")
    
    var isPlaceOrderButtonEnapled: Observable<Bool> {
        return nameBehavior.asObservable().map { (name) -> Bool in
            let isNameEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return !isNameEmpty
        }
    }
    
    let api: FoodAPIProtocol
   
    
    init(dish: Dish, api: FoodAPIProtocol = FoodAPI()){
        self.dish = dish
        self.api = api
    }
 
    func placingOrder(){
        if Reachability()?.connection != Reachability.Connection.none{
            
            
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
                    self.creatAlert(alertTitle: "Error", alertMessage: error.localizedDescription)
                    
                }
            }
        }
        
    }
    
    deinit{
        coordinator?.removeFromParant()
        print("deinit DishDetailViewModel")
    }
}
