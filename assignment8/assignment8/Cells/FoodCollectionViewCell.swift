//
//  FoodCollectionViewCell.swift
//  assignment8
//
//  Created by Yusuke Ishihara on 2022-05-30.
//

import UIKit

class FoodCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "FoodCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    lazy var priceLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    lazy var countryLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    lazy var countryPriceLabelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [countryLabel, priceLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        
        return stack
    }()
    
    lazy var detailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, countryPriceLabelStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        
        return stack
    }()
    
    lazy var imageDescriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, detailStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.backgroundColor = .white
        stack.layer.borderColor = UIColor.black.cgColor
        stack.layer.borderWidth = 0.5
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        addSubview(imageDescriptionStack)
        
        NSLayoutConstraint.activate([
            imageDescriptionStack.topAnchor.constraint(equalTo: topAnchor),
            imageDescriptionStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageDescriptionStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageDescriptionStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            detailStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ food: Food) {
        nameLabel.text = food.name
        priceLabel.text = food.formattedPrice
        countryLabel.text = food.country
        imageView.image = food.image
    }
}
