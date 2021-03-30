//
//  ProductListInteractor.swift
//  ProductListScene
//
//  Created by maxime wacker on 25/03/2021.
//

import GenRouting

import BusinessEntities

// Router
public enum ProductListRouteDestination {
    case productDetail(productID: UInt)
}

public protocol ProductListRoutering: GenRouting {
    func route(to destination: ProductListRouteDestination)
}

// Presenter
public protocol ProductListPresentering {
    func updateList()
}


// Data Store
public protocol ProductDataStoring: AnyObject {
    func loadProducts(done: @escaping ()->Void)
    var productsCount: Int {get}
    func productID(at rank: Int) -> UInt?
    func product(id: UInt) -> ProductRecord?

}


final class ProductListInteractor: ProductListInteractoring {

    var productsCount: Int {_dataStore.productsCount}
    
    func productID(at row: Int) -> UInt? {
        _dataStore.productID(at: row)
    }
    
    let _presenter: ProductListPresentering
    let _dataStore: ProductDataStoring
    
    
    public init(
        presenter: ProductListPresentering,
        dataStore: ProductDataStoring
    ) {
        self._presenter = presenter
        self._dataStore = dataStore
        _dataStore.loadProducts { [weak self] in
            self?._presenter.updateList()
        }
    }
    
}
