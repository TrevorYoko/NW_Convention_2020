//
//  HotelMapTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 11/19/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class HotelMapTableViewCell: UITableViewCell {
    
    let mapImageView = UIImageView.init()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let mapImage = UIImage.init(named: "HotelMap")
        self.mapImageView.image = mapImage
        mapImageView.translatesAutoresizingMaskIntoConstraints = false
        mapImageView.contentMode = .scaleAspectFit
        mapImageView.layer.cornerRadius = 10
        mapImageView.clipsToBounds = true
        
        self.contentView.addSubview(mapImageView)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(item: mapImageView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 10))
        constraints.append(NSLayoutConstraint(item: mapImageView, attribute: .left, relatedBy: .equal, toItem: self.contentView, attribute: .left, multiplier: 1, constant: 15))
        constraints.append(NSLayoutConstraint(item: mapImageView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10))
        constraints.append(NSLayoutConstraint(item: mapImageView, attribute: .right, relatedBy: .equal, toItem: self.contentView, attribute: .right, multiplier: 1, constant: -15))
        constraints.append(NSLayoutConstraint(item: mapImageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: mapImageView, attribute: .width, multiplier: (mapImage?.size.height)!/(mapImage?.size.width)!, constant: 0))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public func centerMap(atX x: CGFloat, atY y: CGFloat) {
        let mapImage = UIImage.init(named: "HotelMap")
        let height: CGFloat = (mapImage?.size.height)! / 3
        let width: CGFloat = (mapImage?.size.width)! / 3
        let rect = CGRect.init(x: x - (height / 2), y: y - (width / 2), width: width, height: height)
        let imageRef = mapImage?.cgImage?.cropping(to: rect)
        self.mapImageView.image = UIImage.init(cgImage: imageRef!)
        self.mapImageView.contentMode = .scaleAspectFill
    }
    
}
