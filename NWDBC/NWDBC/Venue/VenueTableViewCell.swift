//
//  VenueTableviewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 11/20/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class VenueTableViewCell: UITableViewCell {
    
    private let mainTitleLabel: UILabel!
    private let subtitleLabel: UILabel!
    private let button: UIButton!
    private var subtitleBottomConstraint: NSLayoutConstraint?
    private var buttonConstraints: [NSLayoutConstraint] = []
    private var buttonBlock: (()->(Void))?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        self.mainTitleLabel = UILabel.init()
        self.subtitleLabel = UILabel.init()
        self.button = UIButton.init()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.mainTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.mainTitleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.subtitleLabel.numberOfLines = 0
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.setTitleColor(AppTheme.mainColor, for: .normal)
        self.button.setTitle("Click Me", for: .normal)
        self.button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        self.contentView.addSubview(self.mainTitleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(item: mainTitleLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 10))
        constraints.append(NSLayoutConstraint(item: mainTitleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 10))
        constraints.append(NSLayoutConstraint(item: mainTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -10))
        
        constraints.append(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: mainTitleLabel, attribute: .bottom, multiplier: 1, constant: 10))
        constraints.append(NSLayoutConstraint(item: subtitleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 10))
        constraints.append(NSLayoutConstraint(item: subtitleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -10))
        self.subtitleBottomConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10)
        self.subtitleBottomConstraint?.isActive = true
        
        self.buttonConstraints.append(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: subtitleLabel, attribute: .bottom, multiplier: 1, constant: 10))
        self.buttonConstraints.append(NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 10))
        self.buttonConstraints.append(NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -10))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.mainTitleLabel.text = nil
        self.subtitleLabel.text = nil
        
        self.button.removeFromSuperview()
        self.subtitleBottomConstraint?.isActive = true
        NSLayoutConstraint.deactivate(self.buttonConstraints)
    }
    
    func setTitle(_ title: String?) {
        self.mainTitleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: String?) {
        self.subtitleLabel.text = subtitle
    }
    
    func setButtonTitle(title: String, onClickBlock: @escaping ()->(Void)) {
        self.button.setTitle(title, for: .normal)
        self.buttonBlock = onClickBlock
        self.button.addTarget(self, action: #selector(callButtonBlock), for: .touchUpInside)
        
        self.contentView.addSubview(self.button)
        self.subtitleBottomConstraint?.isActive = false
        NSLayoutConstraint.activate(self.buttonConstraints)
    }
    
    @objc private func callButtonBlock() {
        if self.buttonBlock != nil {
            self.buttonBlock!()
        }
    }
}

