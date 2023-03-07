//
//  PropertyDetailService.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation

final class PropertyDetailService: PropertyDetailServiceProtocol {
    func getPropertyDetail(with id: String, completion: ((Result<PropertyDetail, Error>) -> ())? = nil) {
        NetworkLayer.request(router: ApiRouter.getPropertyDetail(id: id)) { (result: Result<PropertyDetail, Error>) in
            completion?(result)
        }
    }
}
