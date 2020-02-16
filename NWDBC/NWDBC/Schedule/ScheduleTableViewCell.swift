//
//  ScheduleTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/10/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    private let colorView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.colorView = UIView.init()
        
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.colorView.frame = CGRect.init(x: 0, y: 0, width: 10, height: self.contentView.frame.size.height)
        self.colorView.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        self.contentView.addSubview(colorView)
        
        self.textLabel?.numberOfLines = 0
        self.detailTextLabel?.numberOfLines = 0
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.colorView.backgroundColor = UIColor.clear
        
    }
    
    func setColor(color: UIColor) {
        self.colorView.backgroundColor = color
    }
}
