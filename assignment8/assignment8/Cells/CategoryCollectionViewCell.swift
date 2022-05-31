//
//  CategoryCollectionViewCell.swift
//  assignment8
//
//  Created by Yusuke Ishihara on 2022-05-30.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCollectionViewCell"
    
    var isOn = false
    lazy var nameButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 10
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isUserInteractionEnabled = false
        
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameButton)
        NSLayoutConstraint.activate([
            nameButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameButton.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ category: MenuCategory) {
        nameButton.setTitle(category.name, for: .normal)
    }
    
    func toggleButton() {
        if isOn {
            nameButton.backgroundColor = .white
        } else {
            nameButton.backgroundColor = .black
        }
        isOn.toggle()
    }
}
