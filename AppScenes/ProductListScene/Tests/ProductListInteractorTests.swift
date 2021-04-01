//
//  ProductListInteractorTests.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import XCTest

import GenRouting
@testable import BusinessEntities
@testable import ProductListScene

class FakeProductListPresenter: ProductListPresentering {
    var updateListInvoked = false
    func updateList() {
        self.updateListInvoked = true
    }
}

class FakeProductListDataStore: ProductListDataStoring {
    var loadedProducts: [ProductRecord]?
    func loadProducts(done: @escaping () -> Void) {
        loadedProducts  = [
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
    }
    
    var productsCount: Int {
        loadedProducts?.count ?? 0
    }
    
    func productID(at rank: Int) -> UInt? {
        loadedProducts?[rank].id
    }
    
    func product(id: UInt) -> ProductRecord? {
        loadedProducts?.first(where: {$0.id == id})
    }
    
}

class FakeProductListRouter: ProductListRouting {
    func start() {
    }
    
    var detailInvokedProdcutID : UInt?
    
    var viewController = UIViewController()
    var parentRouter: GenRouting? = nil
    var navigator: Navigating? = nil
    
    
    init() {
    }
    
    func route(to destination: ProductListRouteDestination) {
        switch destination {
        case .productDetail(let productID):
            self.detailInvokedProdcutID = productID
        }
    }
}


class ProductListInteractorTests: XCTestCase {
    var fakeProductListPresenter: ProductListPresentering?
    var fakeProductListDataStore: ProductListDataStoring?
    var fakeProductListRouter : ProductListRouting?

    override func setUpWithError() throws {
        fakeProductListPresenter = FakeProductListPresenter() as ProductListPresentering
        fakeProductListDataStore = FakeProductListDataStore() as ProductListDataStoring
        fakeProductListRouter = FakeProductListRouter() as ProductListRouting
    }
    
    override func tearDownWithError() throws {
        fakeProductListPresenter = nil
        fakeProductListDataStore = nil
        fakeProductListRouter = nil
    }
    
    
    
    func test_GIVEN_ProdcutListInteractor_WHEN_Inited_THEN_ProductListDataStoreLoaded() throws {
        //GIVEN
        //WHEN
        _ = ProductListInteractor(
            router: fakeProductListRouter! ,
            presenter: fakeProductListPresenter!,
            productDataStore: fakeProductListDataStore!)
        //THEN
        XCTAssertNotNil((fakeProductListDataStore as? FakeProductListDataStore)?.loadedProducts)
        XCTAssertEqual((fakeProductListDataStore as? FakeProductListDataStore)?.loadedProducts?.count, 2)

        //XCTAssertTrue(((fakeProductListPresenter as? FakeProductListPresenter)?.updateListInvoked ?? false) )
    }

}
