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
    
    var disposeBag = DisposeBag()
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
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
    func subscribeToResponse(){
        
        viewModel.dishes.bind(to: tableView
                                .rx
                                .items(cellIdentifier: DishListTableViewCell.identifier, cellType: DishListTableViewCell.self)){ row, dish, cell in
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
    
    deinit{
        print("deinit ListDishesViewController")
    }
}
