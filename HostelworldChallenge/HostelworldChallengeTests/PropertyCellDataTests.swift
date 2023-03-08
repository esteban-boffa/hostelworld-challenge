//
//  PropertyCellDataTests.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 07/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class PropertyCellDataTests: XCTestCase {

    func test_init_shouldHaveValidData() {
        let propertyCellData = PropertyCellData(
            propertyName: "propertyName",
            propertyType: "propertyType",
            cityName: "cityName",
            overallRatingPercentage: 1,
            thumbnailImage: "thumbnailImage"
        )
        XCTAssertEqual(propertyCellData.propertyName, "propertyName")
        XCTAssertEqual(propertyCellData.propertyType, "propertyType")
        XCTAssertEqual(propertyCellData.cityName, "cityName")
        XCTAssertEqual(propertyCellData.overallRatingPercentage, 1)
        XCTAssertEqual(propertyCellData.thumbnailImage, "thumbnailImage")
    }
}
