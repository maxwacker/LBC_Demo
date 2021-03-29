//
//  ProductListCell.swift
//  ProductListScene
//
//  Created by maxime wacker on 28/03/2021.
//
import UIKit

extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
           
           return scaledImage
       }
   }


final class ProductListCell: UITableViewCell {
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        let textVStack = UIStackView(
            arrangedSubviews: [titleLabel, priceLabel])
        textVStack.backgroundColor = .darkGray
        textVStack.translatesAutoresizingMaskIntoConstraints = false
        textVStack.axis = .vertical
        textVStack.distribution = .fill
        textVStack.spacing = UIStackView.spacingUseSystem
        textVStack.isLayoutMarginsRelativeArrangement = true
        textVStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

        
        
        let topHStack = UIStackView(arrangedSubviews: [productImage, textVStack])
        topHStack.backgroundColor = .blue
        topHStack.translatesAutoresizingMaskIntoConstraints = false
        topHStack.axis = .horizontal
        topHStack.distribution = .fill
        topHStack.spacing = UIStackView.spacingUseSystem
        topHStack.isLayoutMarginsRelativeArrangement = true
        topHStack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        contentView.layoutMargins.right = 5
        contentView.backgroundColor = .red
        
        contentView.addSubview(topHStack)
   
        topHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topHStack.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topHStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
   

    }
    
    var productItem: ProductCellMainViewModel? {
        didSet {
            //productImage.image = product?.productImage
            titleLabel.text = productItem?.title
            priceLabel.text = productItem?.price
        }
    }
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.setContentHuggingPriority(UILayoutPriority(rawValue: 0), for: .horizontal)
        lbl.backgroundColor = .lightGray
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
    
    private let productImage : UIImageView = {
        let image = UIImage(named: "image_download_placeholder")
        let scaledImage = image?.scalePreservingAspectRatio(
            targetSize: CGSize(width: 96, height: 96)
        )
        let imgView = UIImageView(image: scaledImage)
        
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
}

extension ProductListCell: ProductListCelling{
    func updateMain(_ mainViewModel: ProductCellMainViewModel) {
        productItem = mainViewModel
    }
    
    
}
