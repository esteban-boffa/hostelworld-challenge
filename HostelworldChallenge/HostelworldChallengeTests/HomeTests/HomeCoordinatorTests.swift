//
//  HomeCoordinatorTests.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class HomeCoordinatorTests: XCTestCase {

    // MARK: Properties

    var mockedDelegate: MockedHomeCoordinatorDelegate!

    // MARK: setUp

    override func setUp() {
        mockedDelegate = MockedHomeCoordinatorDelegate()
    }

    // MARK: Tests

    func test_init_shouldHaveValidData() {
        var coordinator = HomeCoordinator(presentationStyle: .pushed(nil))
        XCTAssertEqual(coordinator.presentationStyle, .pushed(nil))

        let viewController = UIViewController()
        coordinator = HomeCoordinator(presentationStyle: .presented(viewController))
        XCTAssertEqual(coordinator.presentationStyle, .presented(viewController))

        coordinator = HomeCoordinator(presentationStyle: .sheet(viewController))
        XCTAssertEqual(coordinator.presentationStyle, .sheet(viewController))
    }

    @MainActor
    func test_start_shouldReturnNavigationControllerWithHomeViewControllerAsRoot() throws {
        let coordinator = HomeCoordinator(presentationStyle: .pushed(nil))
        let viewController = coordinator.start()

        let navigationController = try XCTUnwrap(viewController as? UINavigationController)
        let hostingController = navigationController.viewControllers.first as? UIHostingController<HomeView>
        XCTAssertNotNil(hostingController)

        let rootViewController = try XCTUnwrap(coordinator.rootViewController as? UINavigationController)
        let hostingVC = try XCTUnwrap(rootViewController.viewControllers.first as? UIHostingController<HomeView>)
        XCTAssertEqual(hostingVC.title, "Properties")
    }

    @MainActor
    func test_stop_shouldSetNilToRootViewControllerAndCallDidStopHomeCoordinator() throws {
        let coordinator = HomeCoordinator(presentationStyle: .pushed(nil))
        coordinator.delegate = mockedDelegate

        _ = coordinator.start()
        XCTAssertNotNil(coordinator.rootViewController)

        coordinator.stop()
        XCTAssertNil(coordinator.rootViewController)
        XCTAssertEqual(mockedDelegate.didCallDidStopHomeCoordinator, 1)
        
    }

    @MainActor
    func test_showPropertyDetailView_shouldSetPropertyDetailCoordinatorAndSetDelegate() {
        let coordinator = HomeCoordinator(presentationStyle: .pushed(nil))
        _ = coordinator.start()
        XCTAssertNil(coordinator.propertyDetailCoordinator)

        coordinator.showPropertyDetailView(with: "")
        XCTAssertNotNil(coordinator.propertyDetailCoordinator)
        XCTAssertTrue(coordinator.propertyDetailCoordinator?.delegate is HomeCoordinator)
    }
}

// MARK: Mocks

final class MockedHomeCoordinatorDelegate: HomeCoordinatorDelegate {

    // MARK: Properties

    var didCallDidStopHomeCoordinator = 0

    // MARK: Methods

    func didStopHomeCoordinator() {
        didCallDidStopHomeCoordinator += 1
    }
}
