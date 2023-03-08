//
//  PropertyDetailViewModelTests.swift
//  HostelworldChallengeTests
//
//  Created by Esteban Boffa on 08/03/2023.
//

import Foundation
import XCTest
@testable import HostelworldChallenge
import SwiftUI

final class PropertyDetailViewModelTests: XCTestCase {

    // MARK: Tests

    @MainActor
    func test_init_shouldHaveValidDataAndCallFetchPropertyDetailMethod() {
        let mockedService = MockedPropertyDetailService(result: .success)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        XCTAssertEqual(viewModel.id, "1234")
        XCTAssertEqual(mockedService.fetchPropertyDetailMethodWasCalled, 1)
    }

    @MainActor
    func test_fetchPropertyDetail_withSuccessResult_shouldSetPropertyDetailAndShouldSetSuccessState() {
        let mockedService = MockedPropertyDetailService(result: .success)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(viewModel.propertyDetail)
        XCTAssertEqual(viewModel.state, .success)
    }

    @MainActor
    func test_fetchPropertyDetail_withErrorResult_shouldSetErrorState() {
        let mockedService = MockedPropertyDetailService(result: .error)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
        XCTAssertNil(viewModel.propertyDetail)
        XCTAssertEqual(viewModel.state, .error)
    }

    @MainActor
    func test_propertyName_shouldReturnPropertyNameReceivedFromService() {
        let mockedService = MockedPropertyDetailService(result: .success)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertEqual(viewModel.propertyName, "name")
    }

    @MainActor
    func test_address1_shouldReturnAddress1ReceivedFromService() {
        let mockedService = MockedPropertyDetailService(result: .success)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertEqual(viewModel.address1, "address1")
    }

    @MainActor
    func test_address2_whenItIsNotEmpty_shouldReturnAddressReceivedFromService() {
        let mockedService = MockedPropertyDetailService(result: .success)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertEqual(viewModel.address2, "address2")
    }

    @MainActor
    func test_address2_whenItIsEmpty_shouldReturnDefaultMessage() {
        let mockedService = MockedPropertyDetailService(result: .success, emptyAddress: true)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertEqual(viewModel.address2, "No second address provided")
    }

    @MainActor
    func test_hasAddress2_whenItIsNotEmpty_shouldReturnTrue() {
        let mockedService = MockedPropertyDetailService(result: .success)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertTrue(viewModel.hasAddress2)
    }

    @MainActor
    func test_hasAddress2_whenItIsEmpty_shouldReturnFalse() {
        let mockedService = MockedPropertyDetailService(result: .success, emptyAddress: true)
        let viewModel = PropertyDetailViewModel(id: "1234", propertyDetailService: mockedService)
        let expectation = self.expectation(description: "Property Detail Service API call")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)

        XCTAssertFalse(viewModel.hasAddress2)
    }

    // Test the remaining computed properties as above
}

// MARK: Mocks

final class MockedPropertyDetailService: PropertyDetailServiceProtocol {

    enum MockedResult {
        case success
        case error
    }

    // MARK: Properties

    let result: MockedResult
    var fetchPropertyDetailMethodWasCalled = 0
    var emptyAddress: Bool

    // MARK: Init

    init(result: MockedResult, emptyAddress: Bool = false) {
        self.result = result
        self.emptyAddress = emptyAddress
    }

    // MARK: Methods

    func getPropertyDetail(with id: String, completion: ((Result<HostelworldChallenge.PropertyDetail, HostelworldChallenge.NetworkError>) -> ())?) {
        fetchPropertyDetailMethodWasCalled += 1
        if result == .success {
            if emptyAddress {
                let result: Result<HostelworldChallenge.PropertyDetail, HostelworldChallenge.NetworkError> = .success(MockedPropertyDetail.getPropertyDetailWithEmptyAddress2())
                completion?(result)
            } else {
                let result: Result<HostelworldChallenge.PropertyDetail, HostelworldChallenge.NetworkError> = .success(MockedPropertyDetail.getPropertyDetail())
                completion?(result)
            }
        } else {
            let result: Result<HostelworldChallenge.PropertyDetail, HostelworldChallenge.NetworkError> = .failure(.badURL)
            completion?(result)
        }
    }
}
