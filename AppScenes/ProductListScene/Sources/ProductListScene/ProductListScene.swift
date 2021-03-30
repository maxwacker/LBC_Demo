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
    private let _dataStore: ProductDataStoring
    private let _interactor: ProductListInteractor
    private let _viewController: ProductListViewController
    
    
    public init(dataStore: ProductDataStoring) {
//        self._router = ProductListRouter()
//        self._presenter = ProductListPresenter()
        //self._allProductNetWorker = AllProductNetWorker()
        //self._dataStore = ProductDataStore(allProductWorker: self._allProductNetWorker/*, imageWorker: */)
        self._dataStore = dataStore
        self._interactor = ProductListInteractor(presenter: self._presenter, dataStore: self._dataStore)
        self._viewController = ProductListViewController(
            interactor: self._interactor,
            cellFactory: ProductListCellFactory(dataStore: self._dataStore) as ProductListCellFactoring
            )
        
        self._presenter._viewController = self._viewController
        self._router._viewController = self._viewController
    }

}
