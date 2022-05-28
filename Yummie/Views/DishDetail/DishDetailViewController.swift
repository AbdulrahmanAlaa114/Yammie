//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 26/05/2022.
//

import UIKit
import RxSwift
import RxCocoa

class DishDetailViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var placeOrderBtn: UIButton!
    
    var viewModel: DishDetailViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToLoading()
        subscribeToAlert()
        populateView()
        bindTextFieldsToViewModel()
        subscribeIsPlaceOrderEnabled()
        subscribeToPlaceOrderButton()
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
    
    func subscribeToAlert() {
        viewModel.showAlertBehavior.subscribe(onNext: { [weak self] (isShow) in
            guard let self = self else {return}
            if isShow {
                self.showAlert(title: self.viewModel.alertTitle, message: self.viewModel.alertMessage, actions: self.viewModel.alertAction)
            } 
        }).disposed(by: disposeBag)
    }
    
    func bindTextFieldsToViewModel() {
        nameField.rx.text.orEmpty.bind(to: viewModel.nameBehavior).disposed(by: disposeBag)
    }
    
    func subscribeIsPlaceOrderEnabled() {
        viewModel.isPlaceOrderButtonEnapled.bind(to: placeOrderBtn.rx.isEnabled).disposed(by: disposeBag)
    }
    
    func subscribeToPlaceOrderButton() {
        placeOrderBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.viewModel.placingOrder()
            }).disposed(by: disposeBag)
    }
    
    private func populateView() {
        dishImageView.kf.setImage(with: viewModel.dish.image?.asUrl)
        titleLbl.text = viewModel.dish.name
        descriptionLbl.text = viewModel.dish.description
        caloriesLbl.text = viewModel.dish.formattedCalories
    }
    
    deinit {
        print("deinit DishDetailViewController")
    }

}
