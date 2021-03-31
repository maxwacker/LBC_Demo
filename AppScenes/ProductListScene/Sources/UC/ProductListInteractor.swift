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

public protocol ProductListRouting: GenRouting {
    func route(to destination: ProductListRouteDestination)
}

// Presenter
public protocol ProductListPresentering {
    func updateList()
}


final class ProductListInteractor: ProductListInteractoring {

    let _router: ProductListRouting
    let _presenter: ProductListPresentering
    let _productDataStore: ProductListDataStoring
    
    public init(
        router: ProductListRouting,
        presenter: ProductListPresentering,
        productDataStore: ProductListDataStoring
    ) {
        self._router = router
        self._presenter = presenter
        self._productDataStore = productDataStore
        _productDataStore.loadProducts { [weak self] in
            self?._presenter.updateList()
        }
    }
    
    var productsCount: Int {_productDataStore.productsCount}
    
    func productID(at row: Int) -> UInt? {
        _productDataStore.productID(at: row)
    }
    
    func productSelected(at row: Int) {
        _router.route(to: .productDetail(productID: productID(at: row) ?? 0))
    }
    

    
}
