//
//  ProductCellInteractor.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//

import BusinessEntities


// Data Store
public protocol ProductListDataStoring: AnyObject {
    func loadProducts(done: @escaping ()->Void)
    var productsCount: Int {get}
    func productID(at rank: Int) -> UInt?
    func product(id: UInt) -> ProductRecord?

}

public protocol ImageListDataStoring: AnyObject {
    func getImageData(for url: NSURL, completion: @escaping (NSData?) -> Void)
}

protocol ProductListCellPresentering {
    var cell: ProductListCelling? {set get}
    func updateImage()
    func updateMain()
}

