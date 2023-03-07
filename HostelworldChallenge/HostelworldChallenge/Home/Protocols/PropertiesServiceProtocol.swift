//
//  PropertiesServiceProtocol.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation

protocol PropertiesServiceProtocol {

    /// Returns the properties in a city
    ///
    /// - Parameters:
    /// - completion: The completion with a Result<Properties, NetworkError>)
    func getProperties(completion: ((Result<Properties, NetworkError>) -> ())?)
}
