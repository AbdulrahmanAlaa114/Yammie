//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import RxCocoa
import RxSwift
import UIKit

class ListOrdersViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var viewModel: ListOrdersViewModel!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.title
        subscribeToLoading()
        registerCells()
        subscribeToResponse()
        subscribeToSelection()
        viewModel.getData()
    }

    func subscribeToLoading() {
        viewModel.loadingBehavior.subscribe { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.showSpinner()
            } else {
                self.hideSpinner()
            }
        }
        .disposed(by: disposeBag)
    }

    private func registerCells() {
        tableView.registerNib(cell: DishListTableViewCell.self)
    }

    func subscribeToResponse() {
        //
        viewModel.orders.bind(
            to: tableView
                .rx
                .items(
                    cellIdentifier: DishListTableViewCell.identifier,
                    cellType: DishListTableViewCell.self
                )
        ) { _, order, cell in
            guard let dish = order.dish else { return }
            cell.setup(dish: dish)
        }
        .disposed(by: disposeBag)
    }

    func subscribeToSelection() {
        tableView.rx.modelSelected(Order.self)
            .bind { [weak self] order in
                guard let self = self, let dish = order.dish else { return }
                self.viewModel.selected(dish: dish)
            }
            .disposed(by: disposeBag)
    }

    deinit {
        print("deinit ListOrdersViewController")
    }
}
