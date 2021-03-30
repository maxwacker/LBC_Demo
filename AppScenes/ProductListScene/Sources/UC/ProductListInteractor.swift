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


final class ProductListInteractor: ProductListInteractoring {

    var productsCount: Int {_productDataStore.productsCount}
    
    func productID(at row: Int) -> UInt? {
        _productDataStore.productID(at: row)
    }
    
    let _presenter: ProductListPresentering
    let _productDataStore: ProductDataStoring
    
    
    public init(
        presenter: ProductListPresentering,
        productDataStore: ProductDataStoring
    ) {
        self._presenter = presenter
        self._productDataStore = productDataStore
        _productDataStore.loadProducts { [weak self] in
            self?._presenter.updateList()
        }
    }
    
}
