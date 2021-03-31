//
//  ProductDetailInteractor.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import GenRouting

import BusinessEntities

// Router
public enum ProductDetailRouteDestination {
    case back
}

public protocol ProductDetailRouting: GenRouting {
    func route(to destination: ProductDetailRouteDestination)
}

// Presenter
public protocol ProductDetailPresentering {
    func updateDetail()
}

final class ProductDetailInteractor: ProductDetailInteractoring {
    
}
