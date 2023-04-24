//
//  HomeViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import RxCocoa
import RxSwift
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var specialsCollectionView: UICollectionView!

    var viewModel: HomeViewModel!
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        subscribeToAlert()
        subscribeToLoading()
        registerCells()
        subscribeToResponse()
        subscribeToSelection()
        viewModel.getData()
    }

    func subscribeToAlert() {
        viewModel.showAlertBehavior.subscribe { [weak self] isShow in
            guard let self = self else { return }
            if isShow {
                self.showAlert(
                    title: self.viewModel.alertTitle,
                    message: self.viewModel.alertMessage,
                    actions: self.viewModel.alertAction
                )
            }
        }
        .disposed(by: disposeBag)
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

    func setupUI() {
        navigationController?.navigationBar.isHidden = false
        title = viewModel.title
        let orderListBtn = UIBarButtonItem(
            image: UIImage(systemName: "cart.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(goToListOrder)
        )
        orderListBtn.tintColor = DesignSystem.Colors.primary.color
        navigationItem.rightBarButtonItem = orderListBtn
    }

    @objc func goToListOrder() {
        viewModel.listOrderTapped()
    }

    func subscribeToResponse() {
        viewModel.categoriesObservable
            .bind(
                to: categoryCollectionView
                    .rx
                    .items(
                        cellIdentifier: CategoryCollectionViewCell.identifier,
                        cellType: CategoryCollectionViewCell.self
                    )
            ) { _, category, cell in
                cell.setup(category: category)
            }
            .disposed(by: disposeBag)

        viewModel.popularsObservable
            .bind(
                to: popularCollectionView
                    .rx
                    .items(
                        cellIdentifier: DishPortraitCollectionViewCell.identifier,
                        cellType: DishPortraitCollectionViewCell.self
                    )
            ) { _, dish, cell in
                cell.setup(dish: dish)
            }
            .disposed(by: disposeBag)

        viewModel.specialsObservable
            .bind(
                to: specialsCollectionView
                    .rx
                    .items(
                        cellIdentifier: DishLandscapeCollectionViewCell.identifier,
                        cellType: DishLandscapeCollectionViewCell.self
                    )
            ) { _, dish, cell in
                cell.setup(dish: dish)
            }
            .disposed(by: disposeBag)
    }

    func subscribeToSelection() {
        Observable
            .zip(categoryCollectionView.rx.itemSelected, categoryCollectionView.rx.modelSelected(DishCategory.self))
            .bind { [weak self] selectedIndex, category in
                print(selectedIndex)
                guard let self = self else { return }

                self.viewModel.selected(category: category)
            }
            .disposed(by: disposeBag)

        popularCollectionView.rx.modelSelected(Dish.self)
            .bind { [weak self] dish in
                guard let self = self else { return }

                self.viewModel.selected(dish: dish)
            }
            .disposed(by: disposeBag)

        specialsCollectionView.rx.modelSelected(Dish.self)
            .bind { [weak self] dish in
                guard let self = self else { return }
                self.viewModel.selected(dish: dish)
            }
            .disposed(by: disposeBag)
    }

    private func registerCells() {
        categoryCollectionView.registerNib(cell: CategoryCollectionViewCell.self)
        popularCollectionView.registerNib(cell: DishPortraitCollectionViewCell.self)
        specialsCollectionView.registerNib(cell: DishLandscapeCollectionViewCell.self)
    }
}
