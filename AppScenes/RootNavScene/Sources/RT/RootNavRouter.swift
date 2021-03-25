//
//  RootNavRouter.swift
//  
//
//  Created by maxime wacker on 25/03/2021.
//

import UIKit

import GenRouting

public class DemoVC : UIViewController {
    public override func viewDidLoad() {
        let label = UILabel()
        label.text = "Demo"
        label.backgroundColor = .purple
        self.view = label
    }
}

public final class NavigationRouter {
    private let _navigator: Navigating? = nil
    public /*weak*/ var _viewController: RootNavigatoring?
    
    // FIXME implement real stack of navigation routers
    // https://stackoverflow.com/questions/31462272/stack-implementation-in-swift/63124690
    private var _routerStack = [GenRouting]()
    weak var _parentRouter: GenRouting? = nil
    
    public init(with navigationRoot: GenRouting? = nil) {
        guard let navigationRoot = navigationRoot else {return}
        //navigationRoot?.parentRouter = self
        _routerStack.append(navigationRoot)
    }
        
}

extension NavigationRouter: GenRouting {
    public var viewController: UIViewController {
        //FIXME: Find clever way to avoid this forced-unwrap
        _viewController as! UIViewController
    }
    
    public var navigator: Navigating? {
        //FIXME: Find clever way to avoid this forced-unwrap
        viewController as! UINavigationController
    }
    
    public var parentRouter: GenRouting? {
      _parentRouter
    }
        
    public func start() {
      //parentRouter?.navigator?.push(vc: viewController)
        navigator?.push(vc: DemoVC())
    }
}

extension NavigationRouter: RootNavRouting {}

