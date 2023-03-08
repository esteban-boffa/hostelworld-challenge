//
//  PropertyDetailViewModel.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation
import UIKit

protocol PropertyDetailViewModelDelegate: AnyObject {}

@MainActor
final class PropertyDetailViewModel: ObservableObject {

    enum DetailState {
        case success
        case loading
        case error
    }

    struct Constants {
        static let descriptionTitle = "Description"
        static let directionsTitle = "Directions"
        static let errorMessage = "There was an error. Please go back and try again."
    }

    // MARK: Private Properties

    @Published private(set) var state: DetailState = .loading
    @Published private(set) var image: UIImage?
    private(set) var propertyDetail: PropertyDetail?
    private let propertyDetailService = PropertyDetailService()
    private let id: String

    // MARK: Properties

    weak var delegate: PropertyDetailViewModelDelegate?

    var propertyName: String {
        propertyDetail?.name ?? ""
    }

    var address1: String {
        propertyDetail?.address1 ?? ""
    }

    var address2: String {
        hasAddress2 ? propertyDetail?.address2 ?? "" : "No second address provided"
    }

    var city: String {
        propertyDetail?.city.name ?? ""
    }

    var country: String {
        propertyDetail?.city.country ?? ""
    }

    var description: String {
        propertyDetail?.description ?? ""
    }

    var directions: String {
        propertyDetail?.directions ?? ""
    }

    var propertyImage: UIImage {
        image ?? UIImage()
    }

    var hasAddress2: Bool {
        !(propertyDetail?.address2.isEmpty == true)
    }

    // MARK: Init

    init(id: String) {
        self.id = id
        fetchPropertyDetail()
    }
}

// MARK: Services

extension PropertyDetailViewModel {
    func fetchPropertyDetail() {
        state = .loading
        propertyDetailService.getPropertyDetail(with: id) { [weak self] (result: Result<PropertyDetail, NetworkError>) in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let propertyDetail):
                    #if DEBUG
                    print("SUCCESS!")
                    #endif
                    self.propertyDetail = propertyDetail
                    self.fetchRemoteImage(propertyDetail)
                    self.state = .success
                case .failure(let error):
                    // Handle error
                    // Sometimes it fails because the mocks are returning different types for checkIn.
                    // Some mocks bring Strings and others Ints.
                    self.state = .error
                    #if DEBUG
                    print("ERROR --> \(error)")
                    #endif
                }
            }
        }
    }
}

// MARK: Private methods

private extension PropertyDetailViewModel {
    func fetchRemoteImage(_ propertyDetail: PropertyDetail) {
        let imageURL = getThumbnailImageURLString(propertyDetail)
        NetworkLayer.request(imageUrl: imageURL) { [weak self] image in
            guard let self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.image = image
            }
        }
    }

    func getThumbnailImageURLString(_ propertyDetail: PropertyDetail) -> String {
        guard let image = propertyDetail.images.first else { return "" }
        // Update "http" to "https" to fix the following security error:
        // App Transport Security has blocked a cleartext HTTP connection toucd.hwstatic.comsince it is insecure.
        // Use HTTPS instead or add this domain to Exception Domains in your Info.plist.
        let prefix = image.prefix.replacingOccurrences(of: "http", with: "https")
        return prefix + image.suffix
    }
}
