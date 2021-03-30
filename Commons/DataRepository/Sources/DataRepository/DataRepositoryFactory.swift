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
    
    public var imageDataStore: ImageDataStoring {
        _imageDataStore
    }

    
    private let _productDataStore: ProductDataStoring
    private let _imageDataStore: ImageDataStoring

    private let _allProductNetWorker: AllProductNetWorking = AllProductNetWorker()
    private let _imageLoader: ImageLoading = ImageLoader()

    public init() {
        self._productDataStore = ProductDataStore(allProductWorker: self._allProductNetWorker)
        self._imageDataStore = ImageDataStore(imageLoader: self._imageLoader)
            
    }
    
}
