//
//  OnboardingViewModel.swift
//  Yummie
//
//  Created by Abdulrahman on 09/05/2022.
//

import Foundation
import RxCocoa
import RxSwift

class OnboardingViewModel {


    var slidesBahavior = BehaviorRelay<[OnboardingSlide]>(value:[
        OnboardingSlide(title: "Delicious Dishes", description: "Experience a variety of amazing dishes from different cultures around the world.Experience a variety of amazing dishes from different cultures around the world.", image: #imageLiteral(resourceName: "slide2")),
        OnboardingSlide(title: "World-Class Chefs", description: "Our dishes are prepared by only the best.", image: #imageLiteral(resourceName: "slide1")),
        OnboardingSlide(title: "Instant World-Wide Delivery", description: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "slide3"))

    ])
    var currentPage = BehaviorRelay(value: 0) 
    var coordinator: OnboardingCoordinator?
    
    var indexPath = BehaviorRelay<IndexPath>(value: IndexPath(item: 0, section: 0))
    
    func nextBtnTapped(){
        if currentPage.value == slidesBahavior.value.count - 1 {
            UserDefaults.standard.hasOnboarded = true
            coordinator?.startHome()
        }else{
            currentPage.accept(currentPage.value+1)
            indexPath.accept(IndexPath(item: currentPage.value, section: 0))
        }
    }

}

