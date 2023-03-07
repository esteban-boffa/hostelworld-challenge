//
//  PropertyDetailServiceProtocol.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation

protocol PropertyDetailServiceProtocol {

    /// Returns the details for the requested property
    ///
    /// - Parameters:
    /// - id: The id of the property
    /// - completion: The completion with a Result<PropertyDetail, NetworkError>)
    func getPropertyDetail(with id: String, completion: ((Result<PropertyDetail, NetworkError>) -> ())?)
}
