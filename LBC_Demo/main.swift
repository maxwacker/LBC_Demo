//
//  main.swift
//  LBC_Demo
//
//  Created by maxime wacker on 25/03/2021.
//

import Foundation

import GenRouting

import AppLauncher
import RootNavScene
import ProductListScene
import DataRepository

let dataRepositoryFactory = DataRepositoryFactory()
let rootSceneFactory = RootNavSceneFactory()
let productListSceneFactory = ProductListSceneFactory(
    productDataStore: dataRepositoryFactory.productDataStore,
    imageDataStore: dataRepositoryFactory.imageDataStore
)
rootSceneFactory.router.push(productListSceneFactory.router)

AppLauncher.launchApp(rootRouter: rootSceneFactory.router as GenRouting)
