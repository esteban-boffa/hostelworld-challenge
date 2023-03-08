//
//  HomeCoordinator.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation
import SwiftUI

protocol HomeCoordinatorDelegate: AnyObject {
    func didStopHomeCoordinator()
}

final class HomeCoordinator: CoordinatorProtocol {

    // MARK: Private Constants

    private struct Constants {
        static let homeViewTitle = "Properties"
    }

    // MARK: Properties

    var presentationStyle: CoordinatorPresentationStyle
    var rootViewController: UIViewController?
    var propertyDetailCoordinator: PropertyDetailCoordinator?
    weak var delegate: HomeCoordinatorDelegate?

    @MainActor
    private lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        return viewModel
    }()

    // MARK: Init

    init(presentationStyle: CoordinatorPresentationStyle) {
        self.presentationStyle = presentationStyle
    }

    @MainActor
    func start() -> UIViewController? {
        let viewController = HomeView(viewModel: viewModel).customViewController { [weak self] in
            self?.handleViewDisappearance()
        }
        viewController.title = Constants.homeViewTitle
        rootViewController = UINavigationController(rootViewController: viewController)
        return rootViewController
    }

    func stop() {
        rootViewController = nil
        delegate?.didStopHomeCoordinator()
    }
}

// MARK: Methods

extension HomeCoordinator {
    @MainActor
    func showPropertyDetailView(with id: String) {
        guard let navigationController = rootViewController as? UINavigationController else { return }
        propertyDetailCoordinator = PropertyDetailCoordinator(presentationStyle: .pushed(navigationController), id: id)
        propertyDetailCoordinator?.delegate = self
        _ = propertyDetailCoordinator?.start()
        propertyDetailCoordinator?.showPropertyDetailView()
    }

    func handleViewDisappearance() {}
}

// MARK: PropertyDetailCoordinatorDelegate

extension HomeCoordinator: PropertyDetailCoordinatorDelegate {
    func didStopPropertyDetailCoordinator() {
        propertyDetailCoordinator = nil
    }
}

// MARK: HomeViewModelDelegate

extension HomeCoordinator: HomeViewModelDelegate {
    @MainActor
    func didTapCell(with propertyID: String) {
        showPropertyDetailView(with: propertyID)
    }
}
