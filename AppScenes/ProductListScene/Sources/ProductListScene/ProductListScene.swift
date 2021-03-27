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
    
    public var netWorker: ProductListNetWorking {
        _netWorker
    }

    
    public var viewController: ProductListViewControllering {
        _viewController
    }
    
    
    private let _router: ProductListRouter
    private let _presenter: ProductListPresenter
    private let _netWorker: ProductListNetWorker
    private let _interactor: ProductListInteractor
    private let _viewController: ProductListViewController
    
    
    public init() {
        self._router = ProductListRouter()
        self._presenter = ProductListPresenter()
        self._netWorker = ProductListNetWorker()
        self._interactor = ProductListInteractor(presenter: self._presenter, netWorker: self._netWorker)
        self._viewController = ProductListViewController(interactor: self._interactor)
        
        self._presenter._viewController = self._viewController
        self._router._viewController = self._viewController
    }

}
