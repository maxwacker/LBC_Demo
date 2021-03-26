//
//  ProductListSceneTests.swift
//  ProductListSceneTests
//
//  Created by maxime wacker on 26/03/2021.
//

import XCTest
@testable import BusinessEntities
@testable import ProductListScene

class FakeProductListViewController: ProductListViewControllering {
    var lastReveivedViewModel: ProductListViewModel?
    func viewModelUpdated(_ new: ProductListViewModel) {
        lastReveivedViewModel = new
    }
    
    
}

class ProductListSceneTests: XCTestCase {

    func test_GIVEN_aProductRecord_WHEN_PresenterIsUpdatedWithIt_THEN_ViewControllerShouldReveiveRightViewModel() throws {
        //GIVEN
        let productRecord = ProductRecord(
            id: 12345,
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
        let fakeProductListViewController = FakeProductListViewController()

        let testedProductListPresenter = ProductListPresenter()
        testedProductListPresenter.viewController = fakeProductListViewController
        
        //WHEN
        testedProductListPresenter.update(from: [productRecord])
        
        //THEN
        let expectedItemViewModel = ProductListItemViewModel(
            imageID: "https://host.org/thumb/t.jpg",
            title: "Some Title",
            price: "12.55 €",
            isUrgent: false,
            category: "Maison")
        
        XCTAssertNotNil(fakeProductListViewController.lastReveivedViewModel?.first)
        let testedItemViewModel = fakeProductListViewController.lastReveivedViewModel!.first!
        
        XCTAssertEqual(testedItemViewModel.imageID, expectedItemViewModel.imageID)
        XCTAssertEqual(testedItemViewModel.title, expectedItemViewModel.title)
        XCTAssertEqual(testedItemViewModel.price, expectedItemViewModel.price)
        XCTAssertEqual(testedItemViewModel.isUrgent, expectedItemViewModel.isUrgent)
        XCTAssertEqual(testedItemViewModel.category, expectedItemViewModel.category)
    }



}
