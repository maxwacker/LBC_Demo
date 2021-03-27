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

let rootSceneFactory = RootNavSceneFactory()
let productListSceneFactory = ProductListSceneFactory()
rootSceneFactory.router.push(productListSceneFactory.router)

AppLauncher.launchApp(rootRouter: rootSceneFactory.router as GenRouting)
