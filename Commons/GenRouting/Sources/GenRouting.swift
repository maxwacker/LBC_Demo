//
//  GenRouting.swift
//  Routing
//
//  Created by maxime wacker on 05/03/2021.
//
import UIKit

public protocol Navigating {
    func push(vc: UIViewController)
    func present(vc: UIViewController)
}

extension UINavigationController: Navigating {
    
    public func present(vc: UIViewController) {
        self.present(vc, animated: true)
    }
    
    public func push(vc: UIViewController) {
        self.pushViewController(vc, animated: true)
    }
}

public protocol GenRouting: AnyObject {
    var parentRouter: GenRouting? { get } // Root router has no parent
    var viewController: UIViewController { get }
    var navigator : Navigating? { get }
    func start()
}
