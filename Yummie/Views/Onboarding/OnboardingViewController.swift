//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    
    var coordinator:OnboardingCoordinator?
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        slides = [
            OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.Experience a variety of amazing dishes from different cultures around the world.", image: #imageLiteral(resourceName: "slide2")),
            OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")),
            OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))
        ]
        
        pageControl.numberOfPages = slides.count
     
    }
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            UserDefaults.standard.hasOnboarded = true
            coordinator?.startHome()
            
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
           
        
        }
    }
    
    deinit{
        print("deinit OnboardingViewController")
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height - 50)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
       
    }
}


