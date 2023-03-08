//
//  MockedPropertyDetail.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 08/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class MockedPropertyDetail {
    static func getPropertyDetail() -> PropertyDetail {
        return PropertyDetail(
            id: "id",
            name: "name",
            rating: nil,
            bestFor: [],
            description: "description",
            latitude: "latitude",
            longitude: "longitude",
            address1: "address1",
            address2: "address2",
            directions: "directions",
            city: City(id: "cityID", name: "cityName", country: "country", idCountry: "idCountry"),
            paymentMethods: [],
            policies: [],
            totalRatings: "totalRatings",
            images: [],
            type: "type",
            depositPercentage: 2,
            associations: [],
            checkIn: CheckIn(startsAt: "startsAt", endsAt: "endsAt")
        )
    }

    static func getPropertyDetailWithEmptyAddress2() -> PropertyDetail {
        return PropertyDetail(
            id: "id",
            name: "name",
            rating: nil,
            bestFor: [],
            description: "description",
            latitude: "latitude",
            longitude: "longitude",
            address1: "address1",
            address2: "",
            directions: "directions",
            city: City(id: "cityID", name: "cityName", country: "country", idCountry: "idCountry"),
            paymentMethods: [],
            policies: [],
            totalRatings: "totalRatings",
            images: [],
            type: "type",
            depositPercentage: 2,
            associations: [],
            checkIn: CheckIn(startsAt: "startsAt", endsAt: "endsAt")
        )
    }
}
