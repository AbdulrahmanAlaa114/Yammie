//
//  HomeViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 25/05/2022.
//

import Foundation
import RxSwift


class HomeViewModel{
    
    var title = "Yammie"
    
    
    private var categories = PublishSubject<[DishCategory]>()
    private var populars = PublishSubject<[Dish]>()
    private var specials = PublishSubject<[Dish]>()
    
    var categoriesObservable: Observable<[DishCategory]> { return categories }
    var popularsObservable: Observable<[Dish]> { return populars }
    var specialsObservable: Observable<[Dish]> { return specials }
    
    
    func getData(){
        
        NetworkService.shared.fetchAllCategories { [weak self] (result) in
            switch result {
            case .success(let allDishes):
                guard let self = self else { return }
                self.categories.onNext(allDishes.categories ?? [])
                self.populars.onNext(allDishes.populars ?? [])
                self.specials.onNext(allDishes.specials ?? [])
            case .failure(let error):
                print(error.localizedDescription)
//                ProgressHUD.showError(error.localizedDescription)
                break
            }
        }
        
    }
}
