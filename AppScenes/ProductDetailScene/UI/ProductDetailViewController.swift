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
        let titleLabel = UILabel()
        //lbl.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    private lazy var productImageView: UIImageView = {
        let productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        productImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        return productImageView
    }()
    
    lazy var descriptionView: UITextView = {
        let descriptionView = UITextView()
        //lbl.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        descriptionView.textColor = .black
        //descriptionView.numberOfLines = 0
        descriptionView.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionView.textAlignment = .left
        return descriptionView
    }()

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
        let topVStack = UIStackView(arrangedSubviews: [headerHStack, descriptionView])
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
        DispatchQueue.main.async  {
            self.titleLabel.text = viewModel.title
            self.descriptionView.text = viewModel.description
        }
    }
    
    
}
