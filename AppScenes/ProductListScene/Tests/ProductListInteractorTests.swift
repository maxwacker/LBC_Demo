//
//  ProductListInteractorTests.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import XCTest

@testable import BusinessEntities
@testable import ProductListScene

class FakeProductListPresenter: ProductListPresentering {
    var receivecProductRecords: [ProductRecord]?
    func update(from: [ProductRecord]) {
        self.receivecProductRecords = from
    }
    
    
}

class FakeProductListNetWorker: ProductListNetWorking {
    var loadInvoked = false
    func load(handler: @escaping (Result<[ProductRecord], Error>) -> Void) {
        self.loadInvoked = true
        let productRecords = [
            ProductRecord(
                id: 123,
                category: .home,
                title: "Some Title 123",
                description: "Some Description 123",
                price: 12.55,
                imageRef: ImageRef(
                    smallURL: "https://host.org/small/123s.jpg",
                    thumbURL: "https://host.org/thumb/123t.jpg"
                ),
                creationDate: ISO8601DateFormatter().date(from: "2019-11-01T15:56:59+0000")!,
                isUrgent: false
            ),
            ProductRecord(
                id: 456,
                category: .kid,
                title: "Some Title",
                description: "Some Description",
                price: 12.55,
                imageRef: ImageRef(
                    smallURL: "https://host.org/small/s.jpg",
                    thumbURL: "https://host.org/thumb/t.jpg"
                ),
                creationDate: ISO8601DateFormatter().date(from: "2019-11-02T15:56:59+0000")!,
                isUrgent: true
            )
        ]
        handler(.success(productRecords))
    }
}


class ProductListInteractorTests: XCTestCase {
    var fakeProductListPresenter: FakeProductListPresenter?
    var fakeProductListNetWorker: FakeProductListNetWorker?

    override func setUpWithError() throws {
        fakeProductListPresenter = FakeProductListPresenter()
        fakeProductListNetWorker = FakeProductListNetWorker()
    }
    
    override func tearDownWithError() throws {
        fakeProductListPresenter = nil
        fakeProductListNetWorker = nil
    }
    
    
    
    func test_GIVEN_ProdcutListInteractor_WHEN_LoadProductsInvoked_THEN_WorkerLoadAndPresenterUpdateInvoked() throws {
        //GIVEN
        let testedProductListInteractor = ProductListInteractor(
            presenter: fakeProductListPresenter!,
            netWorker: fakeProductListNetWorker!
        )
        //WHEN
        testedProductListInteractor.loadProducts()
        //THEN
        XCTAssertTrue(fakeProductListNetWorker?.loadInvoked ?? false)
        XCTAssertNotNil(fakeProductListPresenter?.receivecProductRecords)
        XCTAssertEqual(fakeProductListPresenter?.receivecProductRecords?.count, 2)
    }

}
