//
//  ProductCellInteractor.swift
//  ProductListScene
//
//  Created by maxime wacker on 29/03/2021.
//

import BusinessEntities

protocol ProductListCellPresentering {
    var cell: ProductListCelling? {set get}
    //func updateImage(with jpgData: Data)
    func updateMain()
}

