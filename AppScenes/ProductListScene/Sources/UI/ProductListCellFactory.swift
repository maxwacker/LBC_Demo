//
//  ProductListCellFactory.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//

import UIKit

final class ProductListCellFactory: ProductListCellFactoring {
    private let _dataStore: ProductDataStoring
    
    init(dataStore: ProductDataStoring) {
        self._dataStore = dataStore
    }
    
    private func makeCellPresenter(
        cell: ProductListCelling,
        productID: UInt
    ) -> ProductListCellPresentering {
        ProductCellPresenter(cell: cell, dataStore: self._dataStore, productID: productID) as ProductListCellPresentering
    }
    
    func makeProductListCell(at indexPath: IndexPath, in tableView: UITableView) -> ProductListCelling? {
        let cell: ProductListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: type(of: ProductListCell.self)), for: indexPath) as! ProductListCell
        let row = indexPath.row
        if let productID = _dataStore.productID(at: row) as UInt? {
            let cellPresenter = self.makeCellPresenter(cell: cell as ProductListCelling, productID: productID)
            cellPresenter.updateMain()
            //cellPresenter.updateImage() {}
            return cell as ProductListCelling
        } else {
            return nil
        }
    }
    
}
