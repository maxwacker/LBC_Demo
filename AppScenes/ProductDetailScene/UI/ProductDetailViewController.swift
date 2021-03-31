//
//  ProductDetailViewController.swift
//  ProductDetailScene
//
//  Created by maxime wacker on 30/03/2021.
//

import UIKit

public protocol ProductDetailInteractoring {
    func loadContent()
}

final class ProductDetailViewController: UIViewController {
    private let _interactor: ProductDetailInteractoring
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        //lbl.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var topVStack: UIStackView = {
        let topVStack = UIStackView(arrangedSubviews: [titleLabel])
        topVStack.backgroundColor = .lightGray
        topVStack.translatesAutoresizingMaskIntoConstraints = false
        topVStack.axis = .vertical
        topVStack.distribution = .fill
        topVStack.spacing = UIStackView.spacingUseSystem
        topVStack.isLayoutMarginsRelativeArrangement = true
        topVStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return topVStack
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: ProductDetailInteractoring) {
        self._interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topVStack)
        topVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topVStack.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topVStack.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        _interactor.loadContent()
    }
}

extension ProductDetailViewController: ProductDetailViewControllering {
    func refresh(with viewModel: ProductDetailMainViewModel) {
        titleLabel.text = viewModel.title
    }
    
    
}
