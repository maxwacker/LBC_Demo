//
//  ProductListScene.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import GenRouting

public final class ProductListSceneFactory {
    public var router: ProductListRoutering  {
        _router
    }
    
    public var interactor: ProductListInteractoring {
        _interactor
    }
    
    public var presenter: ProductListPresentering {
        _presenter
    }
    
    public var viewController: ProductListViewControllering {
        _viewController
    }
    
    
    private let _router: ProductListRouter  = ProductListRouter()
    private let _presenter: ProductListPresenter = ProductListPresenter()
    private let _productDataStore: ProductDataStoring
    private let _imageDataStore: ImageDataStoring
    private let _interactor: ProductListInteractor
    private let _viewController: ProductListViewController
    
    
    public init(productDataStore: ProductDataStoring, imageDataStore: ImageDataStoring) {
        self._productDataStore = productDataStore
        self._imageDataStore = imageDataStore
        self._interactor = ProductListInteractor(
            presenter: self._presenter,
            productDataStore: self._productDataStore
        )
        self._viewController = ProductListViewController(
            interactor: self._interactor,
            cellFactory: ProductListCellFactory(
                productDataStore: self._productDataStore,
                imageDataStore: self._imageDataStore
            ) as ProductListCellFactoring
        )
        
        self._presenter._viewController = self._viewController
        self._router._viewController = self._viewController
    }

}
