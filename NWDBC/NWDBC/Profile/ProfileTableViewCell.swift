//
//  ProfileTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 12/13/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ProfileTableviewCell: UITableViewCell {
    
    let profileImageView: UIImageView!
    let nameLabel: UILabel!
    let infoLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        profileImageView = UIImageView.init()
        nameLabel = UILabel.init()
        infoLabel = UILabel.init()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    private func setupView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(infoLabel)
        
        NSLayoutConstraint.init(item: profileImageView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .height, relatedBy: .equal, toItem: profileImageView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: nameLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10).isActive = true

        NSLayoutConstraint.init(item: infoLabel, attribute: .left, relatedBy: .equal, toItem: nameLabel, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: infoLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: infoLabel, attribute: .right, relatedBy: .equal, toItem: nameLabel, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: infoLabel, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10).isActive = true
        
        self.profileImageView.layer.cornerRadius = 40
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        
        self.nameLabel.numberOfLines = 0
        self.nameLabel.lineBreakMode = .byWordWrapping
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.infoLabel.numberOfLines = 0
        self.infoLabel.lineBreakMode = .byWordWrapping
        self.infoLabel.font = UIFont.systemFont(ofSize: 14)
    }
    
    func setupViewWithSpeakerInfo(_ speakerInfo: SpeakerInfo) {
        self.profileImageView.image = UIImage.init(named: speakerInfo.image!)
        self.nameLabel.text = speakerInfo.name
        
        var infoString = ""
        if let title =  speakerInfo.title {
            infoString.append(title)
            infoString.append("\n")
        }
        
        if let temple = speakerInfo.temple {
            infoString.append(temple)
        }
        
        self.infoLabel.text = infoString
    }
    
}
