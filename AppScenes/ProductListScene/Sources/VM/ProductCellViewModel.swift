//
//  ProductCellViewModel.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//

import BusinessEntities

final class ProductCellPresenter: ProductListCellPresentering {
    
    var cell: ProductListCelling?
    private var _productID: UInt
    weak var _dataStore: ProductDataStoring?
    
    init(
        cell: ProductListCelling,
        dataStore: ProductDataStoring,
        productID: UInt) {
        self.cell = cell
        self._dataStore = dataStore
        self._productID = productID
        
    }
    
    func updateMain() {
        guard let model = _dataStore?.product(id:_productID) else {return}
        let newVM = ProductCellMainViewModel(
            productID: model.id,
            title: model.title,
            price: "\(model.price) €",// FIXME Format with cents
            isUrgent: model.isUrgent,
            category: model.category.displayName())
        cell?.updateMain(newVM)
    }
    
}
