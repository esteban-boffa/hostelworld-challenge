//
//  MockedProperties.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 08/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class MockedProperties {
    static func getProperties() -> Properties {
        let property = Property(
            id: "id",
            name: "name",
            city: City(id: "cityID", name: "cityName", country: "country", idCountry: "idCountry"),
            latitude: "latitude",
            longitude: "longitude",
            type: "type",
            images: [PropertyImage(suffix: ".jpg", prefix: "http:ucd.hwstatic.compropertyimages660033")],
            overallRating: OverallRating(overall: 1, numberOfRatings: 2)
        )
        return Properties(
            properties: [
                property,
                property,
                property,
            ]
        )
    }
}
