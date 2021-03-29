//
//  ProductListPresenter.swift
//  ProductListScene
//
//  Created by maxime wacker on 25/03/2021.
//

import BusinessEntities

typealias ProductID = UInt

public struct ProductCellMainViewModel {
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

public protocol ProductListViewControllering: AnyObject {
    func reloadTable()
}

extension ProductCategory {
    func displayName(for locale: String? = Locale.current.languageCode) -> String {
        // FIXME : Read these values from localization files
        let FRfr = [ "Non déterminé", "Véhicule","Mode", "Bricolage", "Maison", "Loisirs", "Immobilier", "Livres/CD/DVD", "Multimédia", "Service","Animaux","Enfants"]
        return FRfr[self.rawValue]
    }
}

final class ProductListPresenter: ProductListPresentering {
    func updateList() {
        _viewController?.reloadTable()
    }
    

    
    weak var _viewController: ProductListViewControllering?    
    
}


