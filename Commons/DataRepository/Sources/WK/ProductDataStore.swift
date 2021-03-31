//
//  ProductDataStore.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//
import BusinessEntities

import ProductListScene
import ProductDetailScene

// Worker
public protocol AllProductNetWorking {
    func load(handler: @escaping (Result<[ProductRecord], Error>) -> Void)
}

protocol ImageNetWorking {
    func loadJPG(from: URL, handler: @escaping (Result<Data, Error>) -> Void)
}

final class ProductDataStore: ProductListDataStoring & ProductDetailDataStoring {
    private var _productModels = [ProductRecord]()
    
    private var _idToRecordIdx = [UInt: Int]()
    private var _URLToJPGData = [URL: Data]()
    
    private var _allProductsNetWorking: AllProductNetWorking
        
    init(
        allProductWorker: AllProductNetWorking = AllProductNetWorker()
        ) {
        self._allProductsNetWorking = allProductWorker
    }

    
    func product(id: UInt) -> ProductRecord? {
        guard let recordIndex = _idToRecordIdx[id] else {return nil}
        return _productModels[recordIndex]
    }
    
    var productsCount: Int {
        _productModels.count
    }
    
    func productID(at rank: Int) -> UInt? {
        return _productModels[rank].id as UInt
    }
    
    private func buildIDIdx() {
        _idToRecordIdx = [UInt: Int]()
        _productModels.enumerated().forEach { (index, product ) in
            _idToRecordIdx[product.id] = index
        }
    }
    
    func loadProducts(done: @escaping ()->Void) {
        _allProductsNetWorking.load() { [ weak self]
            ( result: Result<[ProductRecord], Error>) in
            switch result {
            case .success( let products):
                self?._productModels = products
                self?.buildIDIdx()
                done()
                break
            case .failure(let error):
                // FIXME : Handle Error properly
                print(error)
                done()
                break
            }
        }
    }
}
