//
//  RootNavInteractor.swift
//  
//
//  Created by maxime wacker on 25/03/2021.
//

import GenRouting

public protocol RootNavRouting: GenRouting {
    func push(_ router: GenRouting)
}

public class RootNavInteractor: RootNavInteractoring {}

