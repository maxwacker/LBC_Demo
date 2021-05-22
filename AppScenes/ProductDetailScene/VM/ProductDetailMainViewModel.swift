//
//  ProductDetailMainViewModel.swift
//  ProductDetailScene
//
//  Created by Maxime WACKER on 22/05/2021.
//

public struct ProductDetailMainViewModel {
    let productID: UInt
    let title: String
    let description: String
    let price: String
    let date: String
    let isUrgent: Bool
    let category: String

    internal init(
        productID: UInt,
        title: String,
        description: String,
        price: String,
        date: String,
        isUrgent: Bool,
        category: String
    ) {
        self.productID = productID
        self.title = title
        self.description = description
        self.price = price
        self.date = date
        self.isUrgent = isUrgent
        self.category = category
    }
}
