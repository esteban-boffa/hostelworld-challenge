//
//  PropertyTableViewCellTests.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 08/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class PropertyTableViewCellTests: XCTestCase {

    // MARK: Tests

    func test_setupCell_shouldSetValidData() {
        let cell = PropertyTableViewCell(style: .default, reuseIdentifier: nil)
        let mockedData = MockedPropertyCellData()
        cell.setupCell(mockedData)

        XCTAssertEqual(cell.propertyNameLabel.text, "name")
        XCTAssertEqual(cell.propertyTypeLabel.text, "Type: Hostel")
        XCTAssertEqual(cell.cityNameLabel.text, "City: Dublin")
        XCTAssertEqual(cell.overallRatingLabel.text, "Overall rating: 3%")
    }

    func test_clearViews_shouldSetValidData() {
        let cell = PropertyTableViewCell(style: .default, reuseIdentifier: nil)
        let mockedData = MockedPropertyCellData()
        cell.setupCell(mockedData)
        cell.propertyImageView.image = UIImage()

        XCTAssertEqual(cell.propertyNameLabel.text, "name")
        XCTAssertEqual(cell.propertyTypeLabel.text, "Type: Hostel")
        XCTAssertEqual(cell.cityNameLabel.text, "City: Dublin")
        XCTAssertEqual(cell.overallRatingLabel.text, "Overall rating: 3%")
        XCTAssertNotNil(cell.propertyImageView.image)

        cell.prepareForReuse()
        XCTAssertEqual(cell.propertyNameLabel.text, "")
        XCTAssertEqual(cell.propertyTypeLabel.text, "")
        XCTAssertEqual(cell.cityNameLabel.text, "")
        XCTAssertEqual(cell.overallRatingLabel.text, "")
        XCTAssertNil(cell.propertyImageView.image)
    }
}

// MARK: Mocks

final class MockedPropertyCellData: PropertyCellDataProtocol {
    let propertyName = "name"
    let propertyType = "Hostel"
    let cityName = "Dublin"
    let overallRatingPercentage = 3
    let thumbnailImage = "image"
}
