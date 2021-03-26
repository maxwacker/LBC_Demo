//
//  ImageRefTests.swift
//  ProductEntitesTests
//
//  Created by maxime wacker on 26/03/2021.
//

import XCTest
@testable import BusinessEntities

class ImageRefTests: XCTestCase {
    func test_GIVEN_JsonImageURLDefinition_WHEN_Decoding_THEN_ImageRefProperlyInited() {
        let jsonImageRefData = Data("""
                        {
                           "small":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
                           "thumb":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"
                        }
                        """.utf8)
        let decoder = JSONDecoder()
        do {
            let testedImageRef: ImageRef = try decoder.decode(ImageRef.self, from: jsonImageRefData)
            XCTAssertEqual(testedImageRef.smallURL,
                           "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
            XCTAssertEqual(testedImageRef.thumbURL,  "https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
