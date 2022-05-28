//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit
import RxSwift
import RxCocoa
class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
        
    let disposeBag = DisposeBag()
    var viewModel: OnboardingViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        registerCells()
        subscribeToCurrentPage()
        subscribeToResponse()
        subcribeToIndexPath()
        subscribeToNextButton()
        pageControl.numberOfPages = viewModel.slidesBahavior.value.count
        
    }
    
    func subscribeToCurrentPage() {
        
        viewModel.currentPage.bind { [weak self] page in
            guard let self = self else {return}
            self.pageControl.currentPage = page
            if page == self.viewModel.slidesBahavior.value.count - 1 {
                self.nextBtn.setTitle("Get Started", for: .normal)
            } else {
                self.nextBtn.setTitle("Next", for: .normal)
            }
        }.disposed(by: disposeBag)
    }
    
    func subscribeToResponse() {
    
        self.viewModel.slidesBahavior
            .bind(to: self.collectionView
                    .rx
                    .items(cellIdentifier: OnboardingCollectionViewCell.identifier, cellType: OnboardingCollectionViewCell.self)) { _, onboardingSlide, cell in
                cell.setup(onboardingSlide)
            }.disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
    }
    
    func subscribeToNextButton() {
         nextBtn.rx.tap
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard let self = self else { return }
                self.viewModel.nextBtnTapped()
            }).disposed(by: disposeBag)
    }
    
    func subcribeToIndexPath() {
        viewModel.indexPath.bind { [weak self] indexPath in
            guard let self = self else { return }
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }.disposed(by: disposeBag)
    }
    
    deinit {
        print("deinit OnboardingViewController")
    }
    
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 50)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel.currentPage.accept(Int(scrollView.contentOffset.x / width))
        
    }

}
