//
//  ProductListCellFactory.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//

import UIKit

final class ProductListCellFactory: ProductListCellFactoring {
    private let _productDataStore: ProductListDataStoring
    private let _imageDataStore: ImageListDataStoring
    
    init(
        productDataStore: ProductListDataStoring,
        imageDataStore: ImageListDataStoring
    ) {
        self._productDataStore = productDataStore
        self._imageDataStore = imageDataStore
    }
    
    private func makeCellPresenter(
        cell: ProductListCelling,
        productID: UInt
    ) -> ProductListCellPresentering {
        ProductCellPresenter(
            cell: cell,
            productDataStore: self._productDataStore,
            imageDataStore: self._imageDataStore,
            productID: productID) as ProductListCellPresentering
    }
    
    func makeProductListCell(at indexPath: IndexPath, in tableView: UITableView) -> ProductListCelling? {
        let cell: ProductListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: type(of: ProductListCell.self)), for: indexPath) as! ProductListCell
        let row = indexPath.row
        if let productID = _productDataStore.productID(at: row) as UInt? {
            let cellPresenter = self.makeCellPresenter(cell: cell as ProductListCelling, productID: productID)
            cell.presenter = cellPresenter
            cellPresenter.updateMain()
            cellPresenter.updateImage()
            return cell as ProductListCelling
        } else {
            return nil
        }
    }
    
}
