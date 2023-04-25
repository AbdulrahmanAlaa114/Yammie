//
//  ListDishesViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxRelay
import RxSwift

class ListDishesViewModel: BaseViewModel {
    private var dishesPublish = PublishSubject<[Dish]>()
    var dishes: Observable<[Dish]> { dishesPublish }
    var category: DishCategory!
    var title = ""
    var coordinator: ListDishesCoordinator?
    let api: FoodAPIProtocol

    init(category: DishCategory, api: FoodAPIProtocol = FoodAPI()) {
        self.category = category
        self.title = category.name ?? ""
        self.api = api
    }

    func getData() {
        loadingBehavior.accept(true)
        api.fetchCategoryDishes(info: ["categoryId": "\(category.id ?? "")"]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.dishesPublish.onNext(response?.data ?? [])
                self.loadingBehavior.accept(false)
            case let .failure(error):
                self.loadingBehavior.accept(false)
                self.creatAlert(alertTitle: "Error", alertMessage: error.localizedDescription)
            }
        }
    }

    func selected(dish: Dish) {
        coordinator?.goToDishDetail(dish: dish)
    }

    deinit {
        coordinator?.removeFromParant()
        print("deinit ListDishesViewModel")
    }
}
