//
//  PropertiesService.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation

final class PropertiesService: PropertiesServiceProtocol {
    func getProperties(completion: ((Result<Properties, NetworkError>) -> ())? = nil) {
        NetworkLayer.request(router: ApiRouter.getProperties) { (result: Result<Properties, NetworkError>) in
            completion?(result)
        }
    }
}
