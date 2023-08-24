//
//  ListOrdersViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxRelay
import RxSwift

class ListOrdersViewModel: BaseViewModel {
    private var ordersPublish = PublishSubject<[Order]>()
    var orders: Observable<[Order]> { ordersPublish }
    var title = "Orders"
    var coordinator: ListOrdersCoordinator?
    let api: FoodAPIProtocol

    init(api: FoodAPIProtocol = FoodAPI()) {
        self.api = api
    }

    func getData() {
        loadingBehavior.accept(true)
        api.fetchOrders { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):

                self.ordersPublish.onNext(response?.data ?? [])
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
