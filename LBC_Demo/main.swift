//
//  main.swift
//  LBC_Demo
//
//  Created by maxime wacker on 25/03/2021.
//

import Foundation

import GenRouting

import AppLauncher
import DataRepository

import RootNavScene
import ProductListScene
import ProductDetailScene

let dataRepositoryFactory = DataRepositoryFactory()
let rootSceneFactory = RootNavSceneFactory()
//let productDetailScene = ProductDetailSceneFactory(
//    productDataStore: dataRepositoryFactory.productDataStore,
//    imageDataStore: dataRepositoryFactory.imageDataStore
//)
//let productListSceneFactory = ProductListSceneFactory(
//    detailRouter: productDetailScene.router,
//    productDataStore: dataRepositoryFactory.productDataStore,
//    imageDataStore: dataRepositoryFactory.imageDataStore
//)
//let productDetailScene = ProductDetailSceneFactory(
//    dataRepositoryFactory: dataRepositoryFactory
//)
let productListSceneFactory = ProductListSceneFactory(
    dataRepositoryFactory: dataRepositoryFactory as ListDataStoring,
    detailSceneFactoryBuilder: {
        productID in
        ProductDetailSceneFactory(
            dataRepositoryFactory: dataRepositoryFactory as DetailDataStoring,
            productID: productID
        )
    }
)

rootSceneFactory.router.push(productListSceneFactory.router)

AppLauncher.launchApp(rootRouter: rootSceneFactory.router as GenRouting)
