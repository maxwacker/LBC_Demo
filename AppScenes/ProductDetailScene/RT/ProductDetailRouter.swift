//
//  ProductDetailRouter.swift
//  LBC_Demo
//
//  Created by maxime wacker on 30/03/2021.
//

import UIKit
import GenRouting

public final class ProductDetailRouter: GenRouting {
    weak var _viewController: ProductDetailViewControllering?
    private var _parentRouter: GenRouting?

    public init(_ parentRouter: GenRouting? = nil) {
        self._parentRouter = parentRouter
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
        parentRouter?.navigator?.push(vc: viewController)
        // FIXME : This is dirty workaround to avoid crash when gesture occur in Detail Screen
        (parentRouter?.navigator as? UINavigationController)?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
}

extension ProductDetailRouter: ProductDetailRouting {
    
    public func route(to destination: ProductDetailRouteDestination) {
        switch destination {
        case .back:
            break
        }
    }
}
