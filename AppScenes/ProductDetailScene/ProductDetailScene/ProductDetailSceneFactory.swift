//
//  ProductDetailSceneFactory.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import GenRouting

public final class ProductDetailSceneFactory {
    public var router: ProductDetailRouting  {
        _router
    }
    
//    public var interactor: ProductDetailInteractoring {
//        _interactor
//    }
//
//    public var presenter: ProductDetailPresentering {
//        _presenter
//    }
    
    public var viewController: ProductDetailViewControllering {
        _viewController
    }
    
    
    private let _router: ProductDetailRouting = ProductDetailRouter()
//    private let _presenter: ProductDetailPresenter = ProductListPresenter()
//    private let _productDataStore: ProductDataStoring
//    private let _imageDataStore: ImageDataStoring
//    private let _interactor: ProductDetailInteractor
    private let _viewController: ProductDetailViewControllering
    
    
    public init(/*productDataStore: ProductDataStoring, imageDataStore: ImageDataStoring*/) {
//        self._productDataStore = productDataStore
//        self._imageDataStore = imageDataStore
//        self._interactor = ProductListInteractor(
//            presenter: self._presenter,
//            productDataStore: self._productDataStore
//        )
        self._viewController = ProductDetailViewController(
            //interactor: self._interactor,
        )
        
        //self._presenter._viewController = self._viewController
        (self._router as? ProductDetailRouter)?._viewController = self._viewController
    }

}
