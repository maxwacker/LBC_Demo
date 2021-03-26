//
//  ProductCategoryTests.swift
//  ProductEntitesTests
//
//  Created by maxime wacker on 26/03/2021.
//

import XCTest
@testable import BusinessEntities

class ProductCategoryTests: XCTestCase {
    func test_GIVEN_JsonProductDefinition_WHEN_Decoding_THEN_ProductCategoryProperlyInited() {
        let jsonProductCategory = Data("4".utf8)
        let decoder = JSONDecoder()
        do {
            let testedProductCategory: ProductCategory = try decoder.decode(ProductCategory.self, from: jsonProductCategory)
            XCTAssertEqual(testedProductCategory, .home)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func test_GIVEN_UnknownJsonProductDefinition_WHEN_Decoding_THEN_ProductCategoryInitedTo_unknown_() {
        let jsonProductCategory = Data("45".utf8)
        let decoder = JSONDecoder()
        do {
            let testedProductCategory: ProductCategory = try decoder.decode(ProductCategory.self, from: jsonProductCategory)
            XCTAssertEqual(testedProductCategory, ._unknown_)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
