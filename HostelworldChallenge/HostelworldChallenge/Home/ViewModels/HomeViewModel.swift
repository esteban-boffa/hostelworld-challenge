//
//  HomeViewModel.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didTapCell(with propertyID: String)
}

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: Private Properties

    @Published private(set) var showingProgressView = false
    @Published private(set) var properties: Properties?
    private let propertiesService: PropertiesServiceProtocol

    // MARK: Properties

    weak var delegate: HomeViewModelDelegate?

    // MARK: Init

    init(propertiesService: PropertiesServiceProtocol = PropertiesService()) {
        self.propertiesService = propertiesService
        fetchProperties()
    }
}

// MARK: Public methods

extension HomeViewModel {
    func getNumberOfRowsInSection() -> Int {
        properties?.properties.count ?? 0
    }

    func dataForCellAt(indexPath: IndexPath) -> PropertyCellDataProtocol? {
        let property = properties?.properties[indexPath.row]
        guard let property else { return nil }
        return PropertyCellData(
            propertyName: property.name,
            propertyType: property.type,
            cityName: property.city.name,
            overallRatingPercentage: property.overallRating.overall ?? 0,
            thumbnailImage: getThumbnailImageURLString(property)
        )
    }
}

// MARK: Services

extension HomeViewModel {
    func fetchProperties() {
        showingProgressView = true
        propertiesService.getProperties() { [weak self] (result: Result<Properties, NetworkError>) in
            guard let self else { return }
            DispatchQueue.main.async {
                self.showingProgressView = false
                switch result {
                case .success(let properties):
                    #if DEBUG
                    print("SUCCESS!")
                    #endif
                    self.properties = properties
                case .failure(let error):
                    // Handle error
                    #if DEBUG
                    print("ERROR --> \(error)")
                    #endif
                }
            }
        }
    }

    func didSelectRowAt(_ indexPath: IndexPath) {
        let property = properties?.properties[indexPath.row]
        guard let property else { return }
        delegate?.didTapCell(with: property.id)
    }
}

// MARK: Helpers

extension HomeViewModel {
    func getThumbnailImageURLString(_ property: Property) -> String {
        guard let image = property.images.first else { return "" }
        // Update "http" to "https" to fix the following security error:
        // App Transport Security has blocked a cleartext HTTP connection toucd.hwstatic.comsince it is insecure.
        // Use HTTPS instead or add this domain to Exception Domains in your Info.plist.
        let prefix = image.prefix.replacingOccurrences(of: "http", with: "https")
        return prefix + image.suffix
    }
}
