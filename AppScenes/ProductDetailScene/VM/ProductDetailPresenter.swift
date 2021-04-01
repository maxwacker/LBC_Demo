//
//  ProductDetailPresenter.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import BusinessEntities

public protocol ProductDetailViewControllering: AnyObject {
    func refresh(with viewModel: ProductDetailMainViewModel)
    func updateImage(data: Data)
}

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

extension ProductCategory {
    func displayName(for locale: String? = Locale.current.languageCode) -> String {
        // FIXME : Read these values from localization files
        let FRfr = [ "Non déterminé", "Véhicule","Mode", "Bricolage", "Maison", "Loisirs", "Immobilier", "Livres/CD/DVD", "Multimédia", "Service","Animaux","Enfants"]
        return FRfr[self.rawValue]
    }
}

final class ProductDetailPresenter: ProductDetailPresentering {
    static var priceFormatter: NumberFormatter {
        let priceFormatter = NumberFormatter()
        priceFormatter.numberStyle = .currency
        priceFormatter.currencyCode = "EUR"
        priceFormatter.maximumFractionDigits = 2
        return priceFormatter
    }
    
    static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
    
    weak var _viewController: ProductDetailViewControllering?
    
    func updateDetailMain(_ productRecord:ProductRecord){
        _viewController?.refresh(
            with: ProductDetailMainViewModel(
                productID: productRecord.id,
                title: productRecord.title,
                description: productRecord.description,
                price: ProductDetailPresenter.priceFormatter.string(from: productRecord.price as NSNumber) ?? "",
                date: "publié le \(ProductDetailPresenter.dateFormatter.string(from: productRecord.creationDate))",
                isUrgent: productRecord.isUrgent,
                category: "Catégorie : \(productRecord.category.displayName())"
            )
        )
    }
    
    func updateDetailImage(data : Data) {
            guard let data = data as Data? else {return}
        self._viewController?.updateImage(data: data)
        }
}
