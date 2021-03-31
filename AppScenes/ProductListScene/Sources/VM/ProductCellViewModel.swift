//
//  ProductCellViewModel.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//

import BusinessEntities

final class ProductCellPresenter: ProductListCellPresentering {
    
    static var priceformatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "EUR"
        formatter.maximumFractionDigits = 2
        return formatter
    }

        
    weak var cell: ProductListCelling?
    private var _productID: UInt
    weak var _productDataStore: ProductListDataStoring?
    weak var _imageDataStore: ImageListDataStoring?
    private var thumbImageURL: NSURL?
    
    
    init(
        cell: ProductListCelling,
        productDataStore: ProductListDataStoring,
        imageDataStore: ImageListDataStoring,
        productID: UInt) {
        self.cell = cell
        self._productDataStore = productDataStore
        self._imageDataStore = imageDataStore
        self._productID = productID
        
    }
    
    func updateMain() {
        guard let model = _productDataStore?.product(id:_productID) else {return}
        let imageURL = model.imageRef.smallURL ?? model.imageRef.thumbURL ?? ""
        self.thumbImageURL = NSURL(string: imageURL)
        let newVM = ProductCellMainViewModel(
            productID: model.id,
            title: model.title,
            price: ProductCellPresenter.priceformatter.string(from: model.price as NSNumber) ?? "",
            isUrgent: model.isUrgent,
            category: model.category.displayName())
        cell?.updateMain(newVM)
    }
    
    func updateImage() {
        _imageDataStore?.getImageData(for: thumbImageURL!) {[weak self]
            data in
            guard let data = data as Data? else {return}
            self?.cell?.updateImage(data: data)
        }
    }

    
}
