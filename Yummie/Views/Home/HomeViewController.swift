//
//  HomeViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
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
    
    func setupView(){
        
        navigationController?.navigationBar.isHidden = false
        title = viewModel.title
        let orderListBtn = UIBarButtonItem(image: UIImage(systemName: "cart.circle.fill"), style: .plain, target: self, action: #selector(goToListOrder))
        orderListBtn.tintColor = DesignSystem.Colors.primary.color
        navigationItem.rightBarButtonItem = orderListBtn
        
    }
    
    @objc func goToListOrder(){
        viewModel.listOrderTapped()
    }
    
    func subscribeToResponse() {
    
        self.viewModel.categoriesObservable
            .bind(to: self.categoryCollectionView
                    .rx
                    .items(cellIdentifier: CategoryCollectionViewCell.identifier, cellType: CategoryCollectionViewCell.self)){ row, category, cell in
                cell.setup(category: category)
            }.disposed(by: disposeBag)
        
        self.viewModel.popularsObservable
            .bind(to: self.popularCollectionView
                    .rx
                    .items(cellIdentifier: DishPortraitCollectionViewCell.identifier, cellType: DishPortraitCollectionViewCell.self)){ row, dish, cell in
                cell.setup(dish: dish)
            }.disposed(by: disposeBag)
        
        self.viewModel.specialsObservable
            .bind(to: self.specialsCollectionView
                    .rx
                    .items(cellIdentifier: DIshLandscapeCollectionViewCell.identifier, cellType: DIshLandscapeCollectionViewCell.self)){ row, dish, cell in
                cell.setup(dish: dish)
            }.disposed(by: disposeBag)
            
    }
    
    func subscribeToSelection() {
        Observable
            .zip(categoryCollectionView.rx.itemSelected, categoryCollectionView.rx.modelSelected(DishCategory.self))
            .bind {[weak self]  selectedIndex, category in
                print(selectedIndex)
                guard let self = self else {return}
                
                self.viewModel.selected(category: category)
        }
        .disposed(by: disposeBag)
        
        
        popularCollectionView.rx.modelSelected(Dish.self)
            .bind {[weak self] dish in
                guard let self = self else {return}
                
                self.viewModel.selected(dish: dish)
        }
        .disposed(by: disposeBag)
        
         specialsCollectionView.rx.modelSelected(Dish.self)
            .bind {[weak self] dish in
                guard let self = self else {return}
                self.viewModel.selected(dish: dish)
        }
        .disposed(by: disposeBag)
        
        
        
    }
        
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialsCollectionView.register(UINib(nibName: DIshLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DIshLandscapeCollectionViewCell.identifier)
       
    }

}
