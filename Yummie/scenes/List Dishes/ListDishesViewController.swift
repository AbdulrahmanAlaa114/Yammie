//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ListDishesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var disposeBag = DisposeBag()
    var viewModel: ListDishesViewModel!
    
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
        tableView.registerNib(cell: DishListTableViewCell.self)
    }
    
    func subscribeToResponse() {
        
        viewModel.dishes.bind(to: tableView
                                .rx
                                .items(cellIdentifier: DishListTableViewCell.identifier, cellType: DishListTableViewCell.self)) { _, dish, cell in
            cell.setup(dish: dish)
            
        }.disposed(by: disposeBag)
        
    }
    
    func subscribeToSelection() {
        tableView.rx.modelSelected(Dish.self)
            .bind {[weak self] dish in
                guard let self = self else {return}
                
                self.viewModel.selected(dish: dish)
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("deinit ListDishesViewController")
    }
}
