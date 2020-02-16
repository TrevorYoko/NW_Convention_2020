//
//  ImageCollectionViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 12/16/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit
import SDWebImage

class ImageCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView!
    let spinner: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        imageView = UIImageView.init()
        spinner = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
    }
    
    private func setupView() {
        
        self.imageView.contentMode = .scaleAspectFit
        self.imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.imageView.frame = self.contentView.bounds
        self.clipsToBounds = true
        
        self.contentView.addSubview(imageView)
        
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        self.spinner.center = self.contentView.center
        self.contentView.addSubview(self.spinner)
    }
    
    func setupCellWithImageName(_ imageName: String) {
        self.imageView.image = UIImage.init(named: imageName)
    }
    
    func setupCellWithImageUrl(_ imageUrl: String) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        self.imageView.sd_setImage(with: URL.init(string: imageUrl)) { (image, error, cacheType, url) in
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        }
    }
}
