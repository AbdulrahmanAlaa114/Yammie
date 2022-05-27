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
    
    var title = "Yammie"
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var categories = PublishSubject<[DishCategory]>()
    private var populars = PublishSubject<[Dish]>()
    private var specials = PublishSubject<[Dish]>()
    
    var categoriesObservable: Observable<[DishCategory]> { return categories }
    var popularsObservable: Observable<[Dish]> { return populars }
    var specialsObservable: Observable<[Dish]> { return specials }
    
    var coordinator: HomeCoordinator?
     
    
    func getData(){
                
        loadingBehavior.accept(true)
        let api: FoodAPIProtocol = FoodAPI()
        
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
                print(error.localizedDescription)
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
