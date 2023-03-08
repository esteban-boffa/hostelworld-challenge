//
//  PropertyDetailCoordinatorTests.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 08/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class PropertyDetailCoordinatorTests: XCTestCase {

    // MARK: Properties

    var mockedDelegate: MockedPropertyDetailCoordinatorDelegate!

    // MARK: setUp

    override func setUp() {
        mockedDelegate = MockedPropertyDetailCoordinatorDelegate()
    }

    // MARK: Tests

    func test_init_shouldHaveValidData() {
        let navigationController = UINavigationController()
        var coordinator = PropertyDetailCoordinator(presentationStyle: .pushed(navigationController), id: "id")
        XCTAssertEqual(coordinator.presentationStyle, .pushed(navigationController))
        XCTAssertEqual(coordinator.id, "id")

        let viewController = UIViewController()
        coordinator = PropertyDetailCoordinator(presentationStyle: .presented(viewController), id: "id")
        XCTAssertEqual(coordinator.presentationStyle, .presented(viewController))

        coordinator = PropertyDetailCoordinator(presentationStyle: .sheet(viewController), id: "id")
        XCTAssertEqual(coordinator.presentationStyle, .sheet(viewController))
    }

    @MainActor
    func test_start_shouldReturnPropertyDetailUIHostingControllerAndSetItToRootViewController() throws {
        let coordinator = PropertyDetailCoordinator(presentationStyle: .pushed(UINavigationController()), id: "id")
        _ = coordinator.start()

        XCTAssertNotNil(coordinator.rootViewController as? UIHostingController<PropertyDetailView>)
        let hostingController = try XCTUnwrap(coordinator.rootViewController as? UIHostingController<PropertyDetailView>)
        XCTAssertEqual(hostingController.title, "Property detail")
    }

    @MainActor
    func test_stop_shouldSetNilToRootViewControllerAndCallDidStopPropertyDetailCoordinator() throws {
        let coordinator = PropertyDetailCoordinator(presentationStyle: .pushed(UINavigationController()), id: "id")
        coordinator.delegate = mockedDelegate

        _ = coordinator.start()
        XCTAssertNotNil(coordinator.rootViewController)

        coordinator.stop()
        XCTAssertNil(coordinator.rootViewController)
        XCTAssertEqual(mockedDelegate.didCallDidStopPropertyDetailCoordinator, 1)
    }

    @MainActor
    func test_showPropertyDetailView_withPushPresentationStyle_shouldPushPropertyDetailViewHostingController() {
        let coordinator = PropertyDetailCoordinator(presentationStyle: .pushed(UINavigationController()), id: "id")
        _ = coordinator.start()
        coordinator.showPropertyDetailView()

        XCTAssertNotNil(coordinator.navigationController?.viewControllers.last as? UIHostingController<PropertyDetailView>)
    }

    @MainActor
    func test_handleViewDisappearance_withPushedPresentationStyle_shouldSetNilToRootViewControllerAndShouldCallDidStopPropertyDetailCoordinatorMethod() {
        let coordinator = PropertyDetailCoordinator(presentationStyle: .pushed(UINavigationController()), id: "id")
        coordinator.delegate = mockedDelegate

        _ = coordinator.start()
        XCTAssertNotNil(coordinator.rootViewController)

        coordinator.handleViewDisappearance()
        XCTAssertNil(coordinator.rootViewController)
        XCTAssertEqual(mockedDelegate.didCallDidStopPropertyDetailCoordinator, 1)
    }
}

// MARK: Mocks

final class MockedPropertyDetailCoordinatorDelegate: PropertyDetailCoordinatorDelegate {

    // MARK: Properties

    var didCallDidStopPropertyDetailCoordinator = 0

    // MARK: Methods

    func didStopPropertyDetailCoordinator() {
        didCallDidStopPropertyDetailCoordinator += 1
    }
}
