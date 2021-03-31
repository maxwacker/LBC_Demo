//
//  ProductListScene.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import GenRouting
import ProductDetailScene

public protocol ListDataStoring {
    var productListDataStore: ProductListDataStoring {get}
    var imageListDataStore: ImageListDataStoring {get}
}

public final class ProductListSceneFactory {
    public var router: ProductListRouting  {
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
    
    
    private let _router: ProductListRouting
    private let _presenter: ProductListPresentering = ProductListPresenter()
    private let _productDataStore: ProductListDataStoring
    private let _imageDataStore: ImageListDataStoring
    private let _interactor: ProductListInteractor
    private let _viewController: ProductListViewController
    
    
    public init(
        dataRepositoryFactory: ListDataStoring,
        detailSceneFactoryBuilder: @escaping (UInt) -> ProductDetailSceneFactory

    ) {
        self._router = ProductListRouter(
            detailSceneFactoryBuilder: detailSceneFactoryBuilder)
      
        self._productDataStore = dataRepositoryFactory.productListDataStore
        self._imageDataStore = dataRepositoryFactory.imageListDataStore
        self._interactor = ProductListInteractor(
            router: self._router,
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
        
        (self._presenter as? ProductListPresenter)?._viewController = self._viewController
        (self._router as? ProductListRouter)?._viewController = self._viewController
    }

}
