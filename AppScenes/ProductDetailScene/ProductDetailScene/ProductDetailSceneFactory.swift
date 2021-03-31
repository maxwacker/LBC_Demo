//
//  ProductDetailSceneFactory.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import GenRouting

public protocol DetailDataStoring {
    var productDetailDataStore: ProductDetailDataStoring {get}
    var imageDetailDataStore: ImageDetailDataStoring {get}
}

public final class ProductDetailSceneFactory {
    private let _productID: UInt?
    
    public var router: ProductDetailRouting  {
        _router
    }
    
    public var interactor: ProductDetailInteractoring {
        _interactor
    }

    public var presenter: ProductDetailPresentering {
        _presenter
    }
    
    public var viewController: ProductDetailViewControllering {
        _viewController
    }
    
    
    private let _router: ProductDetailRouting = ProductDetailRouter()
    private let _presenter: ProductDetailPresentering = ProductDetailPresenter()
    private let _productDataStore: ProductDetailDataStoring
    private let _imageDataStore: ImageDetailDataStoring
    private let _interactor: ProductDetailInteractor
    private let _viewController: ProductDetailViewControllering
    
    
    public init(
        dataRepositoryFactory: DetailDataStoring,
        productID: UInt
    ) {
        self._productID = productID
        self._productDataStore = dataRepositoryFactory.productDetailDataStore
        self._imageDataStore = dataRepositoryFactory.imageDetailDataStore
        self._interactor = ProductDetailInteractor(
            productID: productID,
            router: self._router,
            presenter: self._presenter,
            productDetailDataStore: self._productDataStore,
            imageDetailDataStore: self._imageDataStore
        )
        self._viewController = ProductDetailViewController(
            interactor: self._interactor
        )
        
        (self._presenter as? ProductDetailPresenter)?._viewController = self._viewController
        (self._router as? ProductDetailRouter)?._viewController = self._viewController
    }

}
