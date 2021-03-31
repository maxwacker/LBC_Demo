//
//  ProdcutDetailPresenter.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import BusinessEntities

public protocol ProductDetailViewControllering: AnyObject {
    //func reload()
}

public struct ProductDetailMainViewModel {
    let productID: UInt
    //let imageID: String?
    let title: String
    let price: String
    let isUrgent: Bool
    let category: String
    
    internal init(productID: UInt, title: String, price: String, isUrgent: Bool, category: String) {
        self.productID = productID
        self.title = title
        self.price = price
        self.isUrgent = isUrgent
        self.category = category
    }
}
