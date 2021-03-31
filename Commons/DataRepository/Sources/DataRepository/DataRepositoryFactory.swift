//
//  DataRepositoryFactory.swift
//  DataRepository
//
//  Created by maxime wacker on 30/03/2021.
//

import ProductListScene
import ProductDetailScene

public final class DataRepositoryFactory {
    public var productListDataStore: ProductListDataStoring {
        _productDataStore
    }
    
    public var imageListDataStore: ImageListDataStoring {
        _imageDataStore
    }

    public var productDetailDataStore: ProductDetailDataStoring {
        _productDataStore
    }
    
    public var imageDetailDataStore: ImageDetailDataStoring {
        _imageDataStore
    }

    
    private let _productDataStore: ProductListDataStoring & ProductDetailDataStoring
    private let _imageDataStore: ImageListDataStoring & ImageDetailDataStoring

    private let _allProductNetWorker: AllProductNetWorking = AllProductNetWorker()
    private let _imageLoader: ImageLoading = ImageLoader()

    public init() {
        self._productDataStore = ProductDataStore(allProductWorker: self._allProductNetWorker)
        self._imageDataStore = ImageDataStore(imageLoader: self._imageLoader)
            
    }
    
}

extension DataRepositoryFactory: ListDataStoring {}
extension DataRepositoryFactory: DetailDataStoring {}

