//
//  Rating.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation

struct Rating: Codable {
    let overall: Int
    let atmosphere: Int
    let cleanliness: Int
    let facilities: Int
    let staff: Int
    let security: Int
    let location: Int
    let valueForMoney: Int
}
