//
//  ProductDetailInteractor.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import GenRouting

import BusinessEntities

// Data Store
public protocol ProductDetailDataStoring: AnyObject {
    func product(id: UInt) -> ProductRecord?
}

public protocol ImageDetailDataStoring: AnyObject {
    func getImageData(for url: NSURL, completion: @escaping (NSData?) -> Void)
}

// Router
public enum ProductDetailRouteDestination {
    case back
}

public protocol ProductDetailRouting: GenRouting {
    func route(to destination: ProductDetailRouteDestination)
}

// Presenter
public protocol ProductDetailPresentering {
    func updateDetail(_ productRecord:ProductRecord)
}

final class ProductDetailInteractor: ProductDetailInteractoring {
    
    let _router: ProductDetailRouting
    let _presenter: ProductDetailPresentering
    let _productDetailDataStore: ProductDetailDataStoring
    
    let _productID: UInt
    
    public init(
        productID: UInt,
        router: ProductDetailRouting,
        presenter: ProductDetailPresentering,
        productDetailDataStore: ProductDetailDataStoring
    ) {
        self._productID = productID
        self._router = router
        self._presenter = presenter
        self._productDetailDataStore = productDetailDataStore
    }
    
    func loadContent() {
        _presenter.updateDetail(_productDetailDataStore.product(id: _productID)!)
    }
    
}
