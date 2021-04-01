//
//  ProductListCell.swift
//  ProductListScene
//
//  Created by maxime wacker on 28/03/2021.
//
import UIKit



final class ProductListCell: UITableViewCell {
    static let loadingViewTag = 10101010

    // Hold a strong ref to presenter to keep it alive
    // Since we have no interactor for the cell in this current
    // implementation
    public var presenter: ProductListCellPresentering?
    private var productImageView = UIImageView()
         
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(topHStack)
        topHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topHStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        productImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        productImageView.layer.cornerRadius = 4.0

        productImageView.contentMode = .scaleAspectFit
        productImageView.clipsToBounds = true
        
        textVStack.addSubview(self.urgentMark)
        urgentMark.trailingAnchor.constraint(equalTo: self.textVStack.trailingAnchor).isActive = true
        textVStack.superview?.bringSubviewToFront(self.urgentMark)

        DispatchQueue.main.async  {
            self.showImageLoading()
        }
        
    }
        
    private lazy var textVStack: UIStackView = {
        let textVStack = UIStackView( arrangedSubviews: [titleLabel, priceLabel])
        textVStack.layer.cornerRadius = 4
        textVStack.backgroundColor = .lightGray
        textVStack.translatesAutoresizingMaskIntoConstraints = false
        textVStack.axis = .vertical
        textVStack.distribution = .fill
        textVStack.spacing = UIStackView.spacingUseSystem
        textVStack.isLayoutMarginsRelativeArrangement = true
        textVStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return textVStack
    }()
        
        
    private lazy var topHStack: UIStackView = {
        let topHStack = UIStackView(arrangedSubviews: [productImageView, textVStack])
        topHStack.translatesAutoresizingMaskIntoConstraints = false
        topHStack.axis = .horizontal
        topHStack.distribution = .fill
        topHStack.spacing = UIStackView.spacingUseSystem
        topHStack.isLayoutMarginsRelativeArrangement = true
        topHStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        contentView.layoutMargins.right = 5
        
        return topHStack
    } ()

    
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
        lbl.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    var urgentMark : UIImageView = {
        let urgentMark = UIImageView()
        urgentMark.image = UIImage(named: "urgent")
        urgentMark.translatesAutoresizingMaskIntoConstraints = false
        urgentMark.widthAnchor.constraint(equalToConstant: 48).isActive = true
        urgentMark.contentMode = .scaleAspectFit
        urgentMark.clipsToBounds = true
        return urgentMark
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        presenter = nil
        titleLabel.text = nil
        priceLabel.text = nil
        DispatchQueue.main.async  {
            self.showImageLoading()
        }
    }
}

extension ProductListCell: ProductListCelling{
    func updateImage(data: Data) {
        let image = UIImage(data: data) ?? UIImage(named: "no_image_found")!
        DispatchQueue.main.async  {
            self.stopLoading()
            self.productImageView.image = image
            self.layoutSubviews()
        }
    }
    
    func updateMain(_ mainViewModel: ProductCellMainViewModel) {
        DispatchQueue.main.async  {
            self.titleLabel.text = mainViewModel.title
            self.priceLabel.text = mainViewModel.price
            //print("cell \(mainViewModel.title) Urgent: \(mainViewModel.isUrgent) ")
            self.urgentMark.image = nil //disabled because bugy
// Horrible bug to be fixed
// When uncommenting next 2 lines, the urgent mark doesn't appear on the same cells as the one
// colored purple but on the cell next to it !!!

//            self.textVStack.backgroundColor = mainViewModel.isUrgent ? UIColor.purple : UIColor.lightGray
//            self.urgentMark.image = mainViewModel.isUrgent ? UIImage(named: "urgent") : nil
            self.layoutSubviews()
        }
    }
    
}
