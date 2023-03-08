//
//  HomeViewModelTests.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 08/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class HomeViewModelTests: XCTestCase {

    // MARK: Tests

    @MainActor
    func test_init_shouldCallFetchProperties() {
        let mockedService = MockedPropertiesService(result: .success)
        _ = HomeViewModel(propertiesService: mockedService)
        XCTAssertEqual(mockedService.getPropertiesMethodWasCalled, 1)
    }

    @MainActor
    func test_fetchProperties_withSuccessResult_shouldSetProperties() {
        let mockedService = MockedPropertiesService(result: .success)
        let viewModel = HomeViewModel(propertiesService: mockedService)
        let expectation = self.expectation(description: "Properties Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertEqual(viewModel.properties?.properties.count, 3)
    }

    @MainActor
    func test_didSelectRowAt_shouldCallDidTapCellMethod() {
        let mockedService = MockedPropertiesService(result: .success)
        let viewModel = HomeViewModel(propertiesService: mockedService)
        let mockedDelegate = MockedHomeViewModelDelegate()
        viewModel.delegate = mockedDelegate

        let expectation = self.expectation(description: "Properties Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        viewModel.didSelectRowAt(IndexPath(row: 1, section: 0))
        XCTAssertEqual(mockedDelegate.didTapCell, 1)
    }

    @MainActor
    func test_getNumberOfRowsInSection_shouldReturnCorrectNumberOfRows() {
        let mockedService = MockedPropertiesService(result: .success)
        let viewModel = HomeViewModel(propertiesService: mockedService)
        let mockedDelegate = MockedHomeViewModelDelegate()
        viewModel.delegate = mockedDelegate

        let expectation = self.expectation(description: "Properties Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertEqual(viewModel.getNumberOfRowsInSection(), 3)
    }

    @MainActor
    func test_dataForCellAt_shouldReturnValidData() {
        let mockedService = MockedPropertiesService(result: .success)
        let viewModel = HomeViewModel(propertiesService: mockedService)
        let mockedDelegate = MockedHomeViewModelDelegate()
        viewModel.delegate = mockedDelegate

        let expectation = self.expectation(description: "Properties Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        let data = viewModel.dataForCellAt(indexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(data?.propertyName, "name")
        XCTAssertEqual(data?.propertyType, "type")
        XCTAssertEqual(data?.cityName, "cityName")
        XCTAssertEqual(data?.overallRatingPercentage, 1)
        XCTAssertEqual(data?.thumbnailImage, "https:ucd.hwstatic.compropertyimages660033.jpg")
    }

    @MainActor
    func test_getThumbnailImageURLString_shouldReturnCorrectURLString() throws {
        let viewModel = HomeViewModel()
        let property = try XCTUnwrap(MockedProperties.getProperties().properties.first)
        let urlString = viewModel.getThumbnailImageURLString(property)
        XCTAssertEqual(urlString, "https:ucd.hwstatic.compropertyimages660033.jpg")
    }
}

// MARK: Mocks

final class MockedPropertiesService: PropertiesServiceProtocol {

    enum MockedResult {
        case success
        case error
    }

    // MARK: Properties

    let result: MockedResult
    var getPropertiesMethodWasCalled = 0

    // MARK: Init

    init(result: MockedResult) {
        self.result = result
    }

    // MARK: Methods

    func getProperties(completion: ((Result<HostelworldChallenge.Properties, HostelworldChallenge.NetworkError>) -> ())?) {
        getPropertiesMethodWasCalled += 1
        if result == .success {
            let result: Result<HostelworldChallenge.Properties, HostelworldChallenge.NetworkError> = .success(MockedProperties.getProperties())
            completion?(result)
        } else {
            let result: Result<HostelworldChallenge.Properties, HostelworldChallenge.NetworkError> = .failure(.badURL)
            completion?(result)
        }
    }
}

final class MockedHomeViewModelDelegate: HomeViewModelDelegate {

    // MARK: Properties

    var didTapCell = 0

    // MARK: Methods

    func didTapCell(with propertyID: String) {
        didTapCell += 1
    }
}
