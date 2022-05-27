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
    
    var categories: [DishCategory] = []
    var populars: [Dish] = []
    var specials: [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = HomeViewModel()
        
        navigationController?.navigationBar.isHidden = false
        title = viewModel.title
        
        
        registerCells()
        subscribeToResponse()
        viewModel.getData()
        
 
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
    
    
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        specialsCollectionView.register(UINib(nibName: DIshLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DIshLandscapeCollectionViewCell.identifier)
       

    }
    
}
//
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case categoryCollectionView:
//            return categories.count
//        case popularCollectionView:
//            return populars.count
//        case specialsCollectionView:
//            return specials.count
//        default: return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        switch collectionView {
//        case categoryCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
//            cell.setup(category: categories[indexPath.row])
//            return cell
//        case popularCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
//            cell.setup(dish: populars[indexPath.row])
//            return cell
//        case specialsCollectionView:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DIshLandscapeCollectionViewCell.identifier, for: indexPath) as! DIshLandscapeCollectionViewCell
//            cell.setup(dish: specials[indexPath.row])
//            return cell
//        default: return UICollectionViewCell()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == categoryCollectionView {
////            let controller = ListDishesViewController.instantiate()
////            controller.category = categories[indexPath.row]
////            navigationController?.pushViewController(controller, animated: true)
//        } else {
////            let controller = DishDetailViewController.instantiate()
////            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
////            navigationController?.pushViewController(controller, animated: true)
//        }
//    }
//}
