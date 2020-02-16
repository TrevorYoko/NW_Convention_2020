//
//  GreetingsCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 12/12/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class GreetingsCell: UICollectionViewCell {

    let imageView: UIImageView!
    let nameLabel: UILabel!
    var rotateImages: [UIImage]! = []
    
    override init(frame: CGRect) {
        imageView = UIImageView.init()
        nameLabel = UILabel.init()
        
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.backgroundColor = UIColor.white
        self.contentView.layer.cornerRadius = 5
        self.contentView.clipsToBounds = true
        
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: imageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: imageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
        NSLayoutConstraint.init(item: imageView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100).isActive = true
        NSLayoutConstraint.init(item: imageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: imageView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
         NSLayoutConstraint.init(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        
        self.imageView.layer.cornerRadius = 50
        self.imageView.clipsToBounds = true
        self.imageView.contentMode = .scaleAspectFill
        
        self.nameLabel.textAlignment = .center
        self.nameLabel.lineBreakMode = .byWordWrapping
        self.nameLabel.numberOfLines = 0
        self.nameLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.layer.removeAllAnimations()
        self.imageView.image = nil
        self.rotateImages.removeAll()
    }
    
    func setupCellWithName(_ name: String, imageName: String) {
        self.imageView.image = UIImage.init(named: imageName)
        self.nameLabel.text = name
    }

}
