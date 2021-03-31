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
    func updateDetailMain(_ productRecord:ProductRecord)
    func updateDetailImage(data: Data)
}

final class ProductDetailInteractor: ProductDetailInteractoring {
    
    let _router: ProductDetailRouting
    let _presenter: ProductDetailPresentering
    let _productDetailDataStore: ProductDetailDataStoring
    let _imageDetailDataStore: ImageDetailDataStoring
    
    let _productID: UInt
    
    public init(
        productID: UInt,
        router: ProductDetailRouting,
        presenter: ProductDetailPresentering,
        productDetailDataStore: ProductDetailDataStoring,
        imageDetailDataStore: ImageDetailDataStoring
    ) {
        self._productID = productID
        self._router = router
        self._presenter = presenter
        self._productDetailDataStore = productDetailDataStore
        self._imageDetailDataStore = imageDetailDataStore
    }
    
    func loadContent() {
        guard let productRecord = _productDetailDataStore.product(id: _productID)
        else { return }
        _presenter.updateDetailMain(productRecord)
        guard let imageURL = NSURL(string :productRecord.imageRef.smallURL ?? productRecord.imageRef.thumbURL ?? "") else { return }
        _imageDetailDataStore.getImageData(for: imageURL) {[weak self]
            data in
            guard let data = data as Data? else {return}
            self?._presenter.updateDetailImage(data: data)
        }
    }
    
}
