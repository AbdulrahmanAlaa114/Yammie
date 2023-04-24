//
//  OnboardingCoordinatorTest.swift
//  YummieTests
//
//  Created by Abdulrahman on 28/05/2022.
//

import XCTest
@testable import Yummie

class OnboardingCoordinatorTest: XCTestCase {
    var sut: OnboardingCoordinator!

    override func setUpWithError() throws {
        sut = OnboardingCoordinator(navigationController: UINavigationController())
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testStart() {
        sut.start()
    }

    func testStartHome() {
        sut.startHome()
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
}
