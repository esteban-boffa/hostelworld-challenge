//
//  ApiRouter.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation

enum ApiRouter {

    case getProperties
    case getPropertyDetail(id: String)

    // MARK: Private constants

    private struct Constants {
        static let scheme = "https"
        static let getHostelworldHost = "private-anon-b357be2487-practical3.apiary-mock.com"
        static let getPropertiesPath = "/cities/1530/properties/"
        static let getPropertyDetailPath = "/properties/"
    }

    // MARK: Properties

    var scheme: String {
        Constants.scheme
    }

    var host: String {
        switch self {
        case .getProperties, .getPropertyDetail(_):
            return Constants.getHostelworldHost
        }
    }

    var path: String {
        switch self {
        case .getProperties:
            return Constants.getPropertiesPath
        case let .getPropertyDetail(id: id):
            return Constants.getPropertyDetailPath + id
        }
    }
}
