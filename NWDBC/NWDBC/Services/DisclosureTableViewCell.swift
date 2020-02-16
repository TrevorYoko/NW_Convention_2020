//
//  DisclosureTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/10/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class DisclosureTableViewCell: UITableViewCell {
    private let customAccessoryImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.customAccessoryImage = UIImageView.init(image: UIImage.init(named: "disclosure-indicator"))
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.accessoryView = self.customAccessoryImage
        self.selectionStyle = .none
        self.customAccessoryImage.isHidden = true
        
        self.textLabel?.numberOfLines = 0
        self.detailTextLabel?.numberOfLines = 0
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customAccessoryImage.isHidden = true
        self.selectionStyle = .none
        
    }
    
    func showCustomAccessory(shouldShow: Bool) {
        self.customAccessoryImage.isHidden = !shouldShow
        self.selectionStyle = shouldShow ? .default : .none
    }
}
