//
//  ScheduleSpeakerTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/9/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ScheduleSpeakerTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView!
    let detailLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        profileImageView = UIImageView.init()
        detailLabel = UILabel.init()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    private func setupView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(detailLabel)
        
        NSLayoutConstraint.init(item: profileImageView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .height, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 80).isActive = true
        NSLayoutConstraint.init(item: profileImageView, attribute: .height, relatedBy: .equal, toItem: profileImageView, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: detailLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: detailLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1.0, constant: 10).isActive = true
        NSLayoutConstraint.init(item: detailLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: -10).isActive = true
        
        
        self.profileImageView.layer.cornerRadius = 40
        self.profileImageView.clipsToBounds = true
        self.profileImageView.contentMode = .scaleAspectFill
        
        self.detailLabel.numberOfLines = 0
        self.detailLabel.lineBreakMode = .byWordWrapping
        self.detailLabel.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func setupViewWithSpeakerInfo(_ speakerInfo: SpeakerInfo) {
        self.profileImageView.image = UIImage.init(named: speakerInfo.image!)
        
        let attributedLabelString = NSMutableAttributedString.init()
        
        let attributedName = NSMutableAttributedString.init(string: speakerInfo.name!)
        attributedName.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange.init(location: 0, length: speakerInfo.name!.count))
        attributedLabelString.append(attributedName)
        
        if let title =  speakerInfo.title {
            let attributedTitle = NSMutableAttributedString.init(string: String.init(format: "\n%@", title))
            attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: attributedTitle.string.count))
            attributedLabelString.append(attributedTitle)
        }
        if let temple = speakerInfo.temple {
            let attributedTemple = NSMutableAttributedString.init(string: String.init(format: "\n%@", temple))
            attributedTemple.addAttribute(.font, value: UIFont.systemFont(ofSize: 14), range: NSRange.init(location: 0, length: attributedTemple.string.count))
            attributedLabelString.append(attributedTemple)
        }

        self.detailLabel.attributedText = attributedLabelString
    }
    
}

