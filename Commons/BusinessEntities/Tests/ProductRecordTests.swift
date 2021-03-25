//
//  ProductRecordTests.swift
//  ProductEntitesTests
//
//  Created by maxime wacker on 25/03/2021.
//

import XCTest
@testable import BusinessEntities

final class ProductRecordTests: XCTestCase {

    func test_GIVEN_JsonProductDefinition_WHEN_Decoding_THEN_EntityProperlyInited() {
        let jsonRecordData = Data("""
               {
                  "id":1461267313,
                  "category_id":4,
                  "title":"Statue homme noir assis en plâtre polychrome",
                  "description":"Magnifique Statuette homme noir assis fumant le cigare en terre cuite et plâtre polychrome réalisée à la main.  Poids  1,900 kg en très bon état, aucun éclat  !  Hauteur 18 cm  Largeur : 16 cm Profondeur : 18cm  Création Jacky SAMSON  OPTIMUM  PARIS  Possibilité de remise sur place en gare de Fontainebleau ou Paris gare de Lyon, en espèces (heure et jour du rendez-vous au choix). Envoi possible ! Si cet article est toujours visible sur le site c'est qu'il est encore disponible",
                  "price":140.00,
                  "images_url":{
                     "small":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-small/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg",
                     "thumb":"https://raw.githubusercontent.com/leboncoin/paperclip/master/ad-thumb/2c9563bbe85f12a5dcaeb2c40989182463270404.jpg"
                  },
                  "creation_date":"2019-11-05T15:56:59+0000",
                  "is_urgent":false
               }
            """.utf8)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let testedProductRecord: ProductRecord = try decoder.decode(ProductRecord.self, from: jsonRecordData)
            XCTAssertEqual(testedProductRecord.id, 1461267313)
            XCTAssertEqual(testedProductRecord.category, .home)
            XCTAssertEqual(testedProductRecord.title, "Statue homme noir assis en plâtre polychrome")
            XCTAssertEqual(testedProductRecord.price, Decimal(140.00))
            XCTAssertEqual(testedProductRecord.creationDate, ISO8601DateFormatter().date(from: "2019-11-05T15:56:59+0000"))
            XCTAssertEqual(testedProductRecord.isUrgent, false)
            XCTAssertNil(testedProductRecord.siret)
        } catch {
            XCTFail(error.localizedDescription)
        }


    }
}
