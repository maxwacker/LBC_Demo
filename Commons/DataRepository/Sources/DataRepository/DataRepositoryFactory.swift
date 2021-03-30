//
//  DataRepositoryFactory.swift
//  DataRepository
//
//  Created by maxime wacker on 30/03/2021.
//

import ProductListScene

public final class DataRepositoryFactory {
    public var productDataStore: ProductDataStoring {
        _productDataStore
    }
    
    private let _productDataStore: ProductDataStoring
    private let _allProductNetWorker: AllProductNetWorking = AllProductNetWorker()

    public init() {
        self._productDataStore = ProductDataStore(allProductWorker: self._allProductNetWorker/*, imageWorker: */)
    }
    
}
