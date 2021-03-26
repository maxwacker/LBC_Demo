//
//  ProductListInteractor.swift
//  ProductListScene
//
//  Created by maxime wacker on 25/03/2021.
//

import Foundation

import BusinessEntities

protocol ProductListPresentering {
    func update(from: [ProductRecord])
}
