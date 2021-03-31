//
//  ProductDetailViewController.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import UIKit

protocol ProductDetailInteractoring {
    
}

final class ProductDetailViewController: UIViewController {
    //private let _interactor: ProductDetailInteractoring
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(/*interactor: ProductDetailInteractoring*/) {
        //self._interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        let lbl = UILabel()
        lbl.backgroundColor = .purple
        lbl.textColor = .black
        lbl.text = "Product Detail"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        self.view = lbl
    }
}

extension ProductDetailViewController: ProductDetailViewControllering {}
