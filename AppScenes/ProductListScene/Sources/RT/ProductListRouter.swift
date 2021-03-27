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
    
    public init(_ parentRouter: GenRouting? = nil) {
        self._parentRouter = parentRouter
    }
    
    public var navigator: Navigating? {
        viewController.navigationController
    }
    
    public var parentRouter: GenRouting? {
      _parentRouter
    }
    
    public var viewController: UIViewController {
      _viewController as! UIViewController // FIX this forced cast ?
    }
    
    public func start() {
        
    }
    
}

extension ProductListRouter: ProductListRoutering {
    public func route(to destination: ProductListRouteDestination) {
        print("Routing to \(destination)")
    }
    
    
}
