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
    static let loadingViewTag = 10101010
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
    
    private var productImageView = UIImageView()

    lazy var headerHStack: UIStackView = {
        let headerHStack = UIStackView(arrangedSubviews: [productImageView, titleLabel])
        headerHStack.backgroundColor = .lightGray
        headerHStack.translatesAutoresizingMaskIntoConstraints = false
        headerHStack.axis = .horizontal
        headerHStack.distribution = .fill
        headerHStack.spacing = UIStackView.spacingUseSystem
        headerHStack.isLayoutMarginsRelativeArrangement = true
        headerHStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return headerHStack
    }()
    
    lazy var topVStack: UIStackView = {
        let topVStack = UIStackView(arrangedSubviews: [headerHStack])
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
    
    
    func showImageLoading(style: UIActivityIndicatorView.Style = .gray){
        let loading = (view.viewWithTag(ProductDetailViewController.loadingViewTag) as? UIActivityIndicatorView) ?? UIActivityIndicatorView(style: style)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
        loading.tag = ProductDetailViewController.loadingViewTag
        productImageView.addSubview(loading)
        loading.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = view.viewWithTag(ProductDetailViewController.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }

}

extension ProductDetailViewController: ProductDetailViewControllering {
    func updateImage(data: Data) {
        let image = UIImage(data: data) ?? UIImage(named: "no_image_found")!
        DispatchQueue.main.async  {
            self.stopLoading()
            self.productImageView.image = image
            self.view.layoutSubviews()
        }
    }
    
    func refresh(with viewModel: ProductDetailMainViewModel) {
        titleLabel.text = viewModel.title
    }
    
    
}
