//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ListOrdersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListOrdersViewModel!
    var disposeBag = DisposeBag()
    
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
        viewModel.loadingBehavior.subscribe(onNext: { [weak self] (isLoading) in
            guard let self = self else {return}
            if isLoading {
                self.showSpinner()
            } else {
                self.hideSpinner()
            }
        }).disposed(by: disposeBag)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
    func subscribeToResponse() {
        //
        viewModel.orders.bind(to: tableView
                                .rx
                                .items(cellIdentifier: DishListTableViewCell.identifier,
                                       cellType: DishListTableViewCell.self)) { _, order, cell in
            cell.setup(dish: order.dish!)
            
        }.disposed(by: disposeBag)
        
    }
    
    func subscribeToSelection() {
        tableView.rx.modelSelected(Order.self)
            .bind {[weak self] order in
                guard let self = self else {return}
                
                self.viewModel.selected(dish: order.dish!)
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("deinit ListOrdersViewController")
    }
}
