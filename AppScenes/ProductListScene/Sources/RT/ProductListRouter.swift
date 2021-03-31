//
//  ProductListRouter.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import UIKit
import GenRouting



public final class ProductListRouter: GenRouting {
    
    weak var _viewController: ProductListViewControllering?
    private var _parentRouter: GenRouting?
    private var _detailRouter: GenRouting?
    
    public init(_ parentRouter: GenRouting? = nil, detailRouter: GenRouting) {
        self._parentRouter = parentRouter
        self._detailRouter = detailRouter
        
        _detailRouter?.parentRouter = self
    }
    
    public var navigator: Navigating? {
        viewController.navigationController
    }
    
    public var parentRouter: GenRouting? {
        get {
            _parentRouter
        }
        set {
            _parentRouter = newValue
        }
    }

    
    public var viewController: UIViewController {
      _viewController as! UIViewController // FIX this forced cast ?
    }
    
    public func start() {
        
    }
    
}

extension ProductListRouter: ProductListRouting {
    public func route(to destination: ProductListRouteDestination) {
        switch destination {
        case .productDetail(let productID):
            // put productID in Scene
            _detailRouter?.start()
        }
    }
    
    
}
