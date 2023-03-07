//
//  PropertyCellDataProtocol.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation

protocol PropertyCellDataProtocol {
    var propertyName: String { get }
    var propertyType: String { get }
    var cityName: String { get }
    var overallRatingPercentage: Int { get }
    var thumbnailImage: String { get }
}
