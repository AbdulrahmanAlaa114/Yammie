//
//  HomeViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 25/05/2022.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel{
    
    
    var alertTitle = ""
    var alertMessage = ""
    var alertAction: [UIAlertAction] = []
    
    var showAlertBehavior = BehaviorRelay<Bool>(value: false)
    
    var title = "Yammie"
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var categories = PublishSubject<[DishCategory]>()
    private var populars = PublishSubject<[Dish]>()
    private var specials = PublishSubject<[Dish]>()
    
    var categoriesObservable: Observable<[DishCategory]> { return categories }
    var popularsObservable: Observable<[Dish]> { return populars }
    var specialsObservable: Observable<[Dish]> { return specials }
    
    var coordinator: HomeCoordinator?
    
    let api: FoodAPIProtocol
   
    init(api: FoodAPIProtocol = FoodAPI()){
        self.api = api
    }
    
    func creatAlert(alertTitle: String, alertMessage: String, alertAction:[UIAlertAction]){
        self.alertTitle = alertTitle
        self.alertMessage = alertMessage
        self.alertAction = alertAction
        self.showAlertBehavior.accept(true)
    }
    
    func getData(){
        
        if Reachability()?.connection != Reachability.Connection.none{
            
            loadingBehavior.accept(true)
            
            
            api.fetchAllCategories { [weak self] result in
                guard let self = self else{ return }
                switch result {
                case .success(let response):
                    
                    self.categories.onNext(response?.data?.categories ?? [])
                    self.populars.onNext(response?.data?.populars ?? [])
                    self.specials.onNext(response?.data?.specials ?? [])
                    self.loadingBehavior.accept(false)
                case .failure(let error):
                    self.loadingBehavior.accept(false)
                    self.creatAlert(alertTitle: "Error", alertMessage: error.localizedDescription, alertAction: [UIAlertAction(title: "Ok", style: .default, handler: { UIAlertAction in
                        self.showAlertBehavior.accept(false)
                    })])
                    
                }
            }
        }
        
    }
    
    
    func selected(category: DishCategory){
        coordinator?.goToListDishes(category: category)
    }
    
    func selected(dish: Dish){
        coordinator?.goToDishDetail(dish: dish)
    }
    
    func listOrderTapped(){
        coordinator?.goToListOrders()
    }
    
    
}
