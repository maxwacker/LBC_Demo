//
//  ProductListNetWorkerIntegrationTests.swift
//  ProductListSceneTests
//
//  Created by maxime wacker on 27/03/2021.
//

import XCTest

import BusinessEntities
@testable import ProductListScene

// WARNING :
// These are integrations tests, not unit tests (not isolated)

// They make real network requests and just check that returned values
// are decodable as Business entities.


class ProductListNetWorkerIntegrationTests: XCTestCase {

    func test_GIVEN_ProductListNetWorker_WHEN_invoked_THEN_returnsDecodedProdcutRecord() throws {
        let expectation = XCTestExpectation(description: "Request to master/listing.json")
        let testedProductListNetWorker = ProductListNetWorker(
            serviceURL: URL(string: "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"))
        testedProductListNetWorker.load() {
            ( result: Result<[ProductRecord], Error>) in
            switch result {
            case .success( let products):
                XCTAssertNotNil(products.first as? ProductRecord)
                expectation.fulfill()
              break
            case .failure(let error):
                XCTFail(error.localizedDescription)
              break
            }
          }
        wait(for: [expectation], timeout: 5.0)
        }
}
