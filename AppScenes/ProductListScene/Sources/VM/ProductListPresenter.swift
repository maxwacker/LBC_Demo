//
//  ProductListPresenter.swift
//  ProductListScene
//
//  Created by maxime wacker on 25/03/2021.
//

import BusinessEntities

public struct ProductListItemViewModel {
    let imageID: String?
    let title: String
    let price: String
    let isUrgent: Bool
    let category: String
    
    internal init(imageID: String?, title: String, price: String, isUrgent: Bool, category: String) {
        self.imageID = imageID
        self.title = title
        self.price = price
        self.isUrgent = isUrgent
        self.category = category
    }
    
}


public typealias ProductListViewModel = [ProductListItemViewModel]

public protocol ProductListViewControllering: AnyObject {
    func viewModelUpdated(_ new: ProductListViewModel)
}

extension ProductCategory {
    func displayName(for locale: String? = Locale.current.languageCode) -> String {
        // FIXME : Read these values from localization files
        let FRfr = [ "Non déterminé", "Véhicule","Mode", "Bricolage", "Maison", "Loisirs", "Immobilier", "Livres/CD/DVD", "Multimédia", "Service","Animaux","Enfants"]
        return FRfr[self.rawValue]
    }
}


final class ProductListPresenter: ProductListPresentering {
    weak var _viewController: ProductListViewControllering?
    func update(from: [ProductRecord]) {
        let newVM:ProductListViewModel = from.map {
            (productRecord: ProductRecord) -> ProductListItemViewModel in
            ProductListItemViewModel(
                imageID: productRecord.imageRef.thumbURL,
                title: productRecord.title,
                price: "\(productRecord.price) €",
                isUrgent: productRecord.isUrgent,
                category: productRecord.category.displayName())
        }
        _viewController?.viewModelUpdated(newVM)
    }
    
    
}
