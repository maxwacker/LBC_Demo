//
//  ProductListInteractor.swift
//  ProductListScene
//
//  Created by maxime wacker on 25/03/2021.
//

import Foundation

import BusinessEntities

protocol ProductListPresentering {
    func update(from: [ProductRecord])
}

protocol ProductListNetWorking {
    func load(handler: @escaping (Result<[ProductRecord], Error>) -> Void)
}

final class ProductListInteractor: ProductListInteractoring {
    let _presenter: ProductListPresentering
    let _netWorker: ProductListNetWorking
    
    public init(
        presenter: ProductListPresentering,
        netWorker: ProductListNetWorking
    ) {
        self._presenter = presenter
        self._netWorker = netWorker
    }
    
    func loadProducts() {
        _netWorker.load() { [ weak self]
            ( result: Result<[ProductRecord], Error>) in
            switch result {
            case .success( let products):
                self?._presenter.update(from: products)
                break
            case .failure(let error):
                // FIXME : Handle Error properly
                print(error)
                break
            }
        }
    }
}
