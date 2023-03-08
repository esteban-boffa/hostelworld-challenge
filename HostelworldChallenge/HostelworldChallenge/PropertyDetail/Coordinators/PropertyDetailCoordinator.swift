//
//  PropertyDetailCoordinator.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation
import SwiftUI

protocol PropertyDetailCoordinatorDelegate: AnyObject {
    func didStopPropertyDetailCoordinator()
}

final class PropertyDetailCoordinator: CoordinatorProtocol {

    // MARK: Private Constants

    private struct Constants {
        static let homeViewTitle = "Property detail"
    }

    let id: String

    // MARK: Properties

    var presentationStyle: CoordinatorPresentationStyle
    var rootViewController: UIViewController?
    var navigationController: UINavigationController?
    weak var delegate: PropertyDetailCoordinatorDelegate?

    @MainActor
    private lazy var viewModel: PropertyDetailViewModel = {
        let viewModel = PropertyDetailViewModel(id: id)
        viewModel.delegate = self
        return viewModel
    }()

    // MARK: Init

    init(presentationStyle: CoordinatorPresentationStyle, id: String) {
        self.presentationStyle = presentationStyle
        self.id = id
    }

    @MainActor
    func start() -> UIViewController? {
        let viewController = PropertyDetailView(viewModel: viewModel).customViewController { [weak self] in
            self?.handleViewDisappearance()
        }
        viewController.title = Constants.homeViewTitle
        rootViewController = viewController
        return rootViewController
    }

    func stop() {
        rootViewController = nil
        delegate?.didStopPropertyDetailCoordinator()
    }
}

// MARK: Public methods

extension PropertyDetailCoordinator {
    func showPropertyDetailView() {
        guard let rootViewController else { return }
        switch presentationStyle {
        case let .pushed(navController):
            navigationController = navController
            navController?.pushViewController(rootViewController, animated: UIView.areAnimationsEnabled)
        default:
            return
        }
    }

    func handleViewDisappearance() {
        switch presentationStyle {
        case .pushed:
            if navigationController?.viewControllers.first(where: { $0 is UIHostingController<PropertyDetailView> }) == nil {
                stop()
            }
        case .presented, .sheet:
            if navigationController?.viewControllers.count == 1 {
                stop()
            }
        }
    }
}

// MARK: PropertyDetailViewModelDelegate

extension PropertyDetailCoordinator: PropertyDetailViewModelDelegate {}
