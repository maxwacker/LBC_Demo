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

let rootSceneFactory = RootNavSceneFactory()
//let productListFactory = ProductListFactory()
//rootSceneFactory.router.routetStack.push(productListFactory.router)

AppLauncher.launchApp(rootRouter: rootSceneFactory.router as GenRouting)
