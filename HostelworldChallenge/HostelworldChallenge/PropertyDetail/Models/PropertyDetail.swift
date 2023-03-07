//
//  PropertyDetail.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation

struct PropertyDetail: Codable {
    let id: String
    let name: String
    let rating: Rating?
    let bestFor: [String]
    let description: String
    let latitude: String
    let longitude: String
    let address1: String
    let address2: String
    let directions: String
    let city: City
    let paymentMethods: [String]
    let policies: [String]
    let totalRatings: String
    let images: [PropertyImage]
    let type: String
    let depositPercentage: Int
    let associations: [String]
    let checkIn: CheckIn
}
