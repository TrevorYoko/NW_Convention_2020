//
//  SubtitleTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/10/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.numberOfLines = 0
        self.detailTextLabel?.numberOfLines = 0
    }
}
