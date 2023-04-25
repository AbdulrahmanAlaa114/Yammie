//
//  HomeViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 25/05/2022.
//

import Foundation
import RxRelay
import RxSwift

class HomeViewModel: BaseViewModel {
    private var categories = PublishSubject<[DishCategory]>()
    private var populars = PublishSubject<[Dish]>()
    private var specials = PublishSubject<[Dish]>()
    var categoriesObservable: Observable<[DishCategory]> { categories }
    var popularsObservable: Observable<[Dish]> { populars }
    var specialsObservable: Observable<[Dish]> { specials }
    var title = "Yammie"
    var coordinator: HomeCoordinator?
    let api: FoodAPIProtocol

    init(api: FoodAPIProtocol = FoodAPI()) {
        self.api = api
    }

    func getData() {
        loadingBehavior.accept(true)
        api.fetchAllCategories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.categories.onNext(response?.data?.categories ?? [])
                self.populars.onNext(response?.data?.populars ?? [])
                self.specials.onNext(response?.data?.specials ?? [])
                self.loadingBehavior.accept(false)
            case let .failure(error):
                self.loadingBehavior.accept(false)
                self.creatAlert(alertTitle: "Error", alertMessage: error.localizedDescription)
            }
        }
    }

    func selected(category: DishCategory) {
        coordinator?.goToListDishes(category: category)
    }

    func selected(dish: Dish) {
        coordinator?.goToDishDetail(dish: dish)
    }

    func listOrderTapped() {
        coordinator?.goToListOrders()
    }
}
