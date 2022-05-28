//
//  ListOrdersViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxSwift
import RxRelay

class ListOrdersViewModel: BaseViewModel{
    
    var title = "Orders"
    
    var coordinator: ListOrdersCoordinator?
 
    
    private var ordersPublish = PublishSubject<[Order]>()
    var orders: Observable<[Order]> { return ordersPublish }
    
    let api: FoodAPIProtocol
   
    init(api: FoodAPIProtocol = FoodAPI()){
        self.api = api
    }
    
    func getData(){
        if Reachability()?.connection != Reachability.Connection.none{
            
            loadingBehavior.accept(true)
            api.fetchOrders { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let response):
                    
                    self.ordersPublish.onNext(response?.data ?? [])
                    self.loadingBehavior.accept(false)
                case .failure(let error):
                    self.loadingBehavior.accept(false)
                    self.creatAlert(alertTitle: "Error", alertMessage: error.localizedDescription)
                    
                }
            }
        }
        
    }
    
    func selected(dish: Dish){
        coordinator?.goToDishDetail(dish: dish)
    }
    
    deinit{
        coordinator?.removeFromParant()
        print("deinit ListDishesViewModel")
    }
    
}
