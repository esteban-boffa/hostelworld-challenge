//
//  Property.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation

struct Property: Codable {
    let id: String
    let name: String
    let city: City
    let latitude: String
    let longitude: String
    let type: String
    let images: [Image]
    let overallRating: OverallRating
}
