//
//  DishDetailViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import Foundation
import RxRelay
import RxSwift

class DishDetailViewModel: BaseViewModel {
    let dish: Dish
    var coordinator: DishDetailCoordinator?
    var nameBehavior = BehaviorRelay<String>(value: "")
    var isPlaceOrderButtonEnapled: Observable<Bool> {
        nameBehavior.asObservable().map { name -> Bool in
            let isNameEmpty = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            return !isNameEmpty
        }
    }

    let api: FoodAPIProtocol

    init(dish: Dish, api: FoodAPIProtocol = FoodAPI()) {
        self.dish = dish
        self.api = api
    }

    func placingOrder() {
        loadingBehavior.accept(true)
        let info = [
            "dishId": "\(dish.id ?? "")",
            "name": nameBehavior.value
        ]

        api.placeOrder(info: info) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.creatAlert(
                    alertTitle: "Success",
                    alertMessage: "Your order has been received. 👨🏼‍🍳"
                )
                self.loadingBehavior.accept(false)
            case let .failure(error):
                self.loadingBehavior.accept(false)
                self.creatAlert(alertTitle: "Error", alertMessage: error.localizedDescription)
            }
        }
    }

    deinit {
        coordinator?.removeFromParant()
        print("deinit DishDetailViewModel")
    }
}
