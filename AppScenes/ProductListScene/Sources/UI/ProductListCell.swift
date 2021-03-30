//
//  ProductListCell.swift
//  ProductListScene
//
//  Created by maxime wacker on 28/03/2021.
//
import UIKit



final class ProductListCell: UITableViewCell {
    static let loadingViewTag = 10101010

    public var presenter: ProductListCellPresentering? // Hold a strong ref to presenter to keep it alive
    private var productImageView = UIImageView()
         
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        productImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true

        let textVStack = UIStackView(
            arrangedSubviews: [titleLabel, priceLabel])
        textVStack.backgroundColor = .lightGray
        textVStack.translatesAutoresizingMaskIntoConstraints = false
        textVStack.axis = .vertical
        textVStack.distribution = .fill
        textVStack.spacing = UIStackView.spacingUseSystem
        textVStack.isLayoutMarginsRelativeArrangement = true
        textVStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        
        
        let topHStack = UIStackView(arrangedSubviews: [productImageView, textVStack])
        topHStack.translatesAutoresizingMaskIntoConstraints = false
        topHStack.axis = .horizontal
        topHStack.distribution = .fill
        topHStack.spacing = UIStackView.spacingUseSystem
        topHStack.isLayoutMarginsRelativeArrangement = true
        topHStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        contentView.layoutMargins.right = 5
        
        contentView.addSubview(topHStack)
        
        topHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topHStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        self.showImageLoading()
        
    }
    
    func showImageLoading(style: UIActivityIndicatorView.Style = .gray){
        let loading = (viewWithTag(ProductListCell.loadingViewTag) as? UIActivityIndicatorView) ?? UIActivityIndicatorView(style: style)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.startAnimating()
        loading.hidesWhenStopped = true
        loading.tag = ProductListCell.loadingViewTag
        productImageView.addSubview(loading)
        loading.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor).isActive = true
        loading.centerXAnchor.constraint(equalTo: productImageView.centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = viewWithTag(ProductListCell.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
    
    
    var productItem: ProductCellMainViewModel? {
        didSet {
            titleLabel.text = productItem?.title
            priceLabel.text = productItem?.price
        }
    }
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        lbl.textColor = .black
        lbl.numberOfLines = 2
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let priceLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        priceLabel.text = nil
        productImageView.image = nil
    }
}

extension ProductListCell: ProductListCelling{
    func updateImage(data: Data) {
        let image = UIImage(data: data) ?? UIImage(named: "image_download_placeholder")!
        DispatchQueue.main.async  {
            self.stopLoading()
            self.productImageView.image = image
            self.layoutSubviews()
        }
    }
    
    func updateMain(_ mainViewModel: ProductCellMainViewModel) {
        DispatchQueue.main.async  {
            self.productItem = mainViewModel
        }
    }
    
    
}
