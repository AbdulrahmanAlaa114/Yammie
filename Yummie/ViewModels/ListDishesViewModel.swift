//
//  ListDishesViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxSwift
import RxRelay
class ListDishesViewModel{
    
    var category: DishCategory!
    var title = ""
    var coordinator: ListDishesCoordinator?
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var dishesPublish = PublishSubject<[Dish]>()
    var dishes: Observable<[Dish]> { return dishesPublish }
    
    let api: FoodAPIProtocol
   
    
    init(category: DishCategory, api: FoodAPIProtocol = FoodAPI()){
        self.category = category
        self.title = category.name ?? ""
        self.api = api
    }
    
    func getData(){
        if Reachability()?.connection != Reachability.Connection.none{
            
            
            loadingBehavior.accept(true)
            api.fetchCategoryDishes(info: ["categoryId" : "\(category.id ?? "")"]) { [weak self] (result) in
                guard let self = self else {return}
                switch result {
                case .success(let response):
                    self.dishesPublish.onNext(response?.data ?? [])
                    self.loadingBehavior.accept(false)
                case .failure(let error):
                    self.loadingBehavior.accept(false)
                    print(error.localizedDescription)
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
