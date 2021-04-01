//
//  ProductListCellPresenterTests.swift
//  ProductListCellPresenterTests
//
//  Created by maxime wacker on 26/03/2021.
//

import XCTest
@testable import BusinessEntities
@testable import ProductListScene

class FakeProductListCell: ProductListCelling {
    var lastReveivedViewModel: ProductCellMainViewModel?
    var updateImageReceived = false
    
    func updateImage(data: Data) {
        self.updateImageReceived = true
    }
    
    func updateMain(_ mainViewModel: ProductCellMainViewModel) {
        lastReveivedViewModel = mainViewModel
    }
}

class FakeImageListDataStore: ImageListDataStoring {
    func getImageData(for url: NSURL, completion: @escaping (NSData?) -> Void) {
        completion(NSData())
    }
    
}

class ProductListCellPresenterTests: XCTestCase {
    var fakeProductListPresenter: ProductListPresentering?
    var fakeProductListDataStore: ProductListDataStoring?
    var fakeImageListDataStore: ImageListDataStoring?

    override func setUpWithError() throws {
        fakeProductListPresenter = FakeProductListPresenter() as ProductListPresentering
        fakeProductListDataStore = FakeProductListDataStore() as ProductListDataStoring
 
        fakeImageListDataStore = FakeImageListDataStore() as ImageListDataStoring
    }
    
    override func tearDownWithError() throws {
        fakeProductListPresenter = nil
        fakeProductListDataStore = nil
    }
    
    func test_GIVEN_aProductRecord_WHEN_CellPresenterIsUpdatedWithIt_THEN_ViewControllerShouldReveiveRightViewModel() throws {
        //GIVEN
        let productRecord = ProductRecord(
            id: 123,
            category: .home,
            title: "Some Title",
            description: "Some Descriptip",
            price: 12.55,
            imageRef: ImageRef(
                smallURL: "https://host.org/small/s.jpg",
                thumbURL: "https://host.org/thumb/t.jpg"
            ),
            creationDate: ISO8601DateFormatter().date(from: "2019-11-05T15:56:59+0000")!,
            isUrgent: false
        )
        (fakeProductListDataStore as! FakeProductListDataStore).loadedProducts = [productRecord]
        let fakeProductListCell = FakeProductListCell()

        let testedProductListCellPresenter = ProductCellPresenter(
            cell: fakeProductListCell,
            productDataStore: fakeProductListDataStore!,
            imageDataStore: fakeImageListDataStore!,
            productID: 123
        )
        //WHEN
        testedProductListCellPresenter.updateMain()
        //THEN
        let expectedItemViewModel = ProductCellMainViewModel(
            productID: 123,
            title: "Some Title",
            price: "€12.55",
            isUrgent: false,
            category: "Maison"
        )
        
        XCTAssertNotNil(fakeProductListCell.lastReveivedViewModel)
        let testedItemViewModel = fakeProductListCell.lastReveivedViewModel!
        
        XCTAssertEqual(testedItemViewModel.title, expectedItemViewModel.title)
        XCTAssertEqual(testedItemViewModel.price, expectedItemViewModel.price)
        XCTAssertEqual(testedItemViewModel.isUrgent, expectedItemViewModel.isUrgent)
        XCTAssertEqual(testedItemViewModel.category, expectedItemViewModel.category)
    }



}

