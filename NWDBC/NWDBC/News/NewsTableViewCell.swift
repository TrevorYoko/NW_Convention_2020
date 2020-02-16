//
//  NewsTableViewCell.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/2/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    let imagePreviewOne: UIImageView!
    let imagePreviewTwo: UIImageView!
    let imagePreviewThree: UIImageView!
    
    let titleLabel: UILabel!
    let dateLabel: UILabel!
    let descriptionLabel: UILabel!
    
    let imagePreviewView: UIView!
    
    let linkButton: UIButton!
    
    var newsInfo: NewsInfo?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        imagePreviewOne = UIImageView.init()
        imagePreviewTwo = UIImageView.init()
        imagePreviewThree = UIImageView.init()
        
        titleLabel = UILabel.init()
        dateLabel = UILabel.init()
        descriptionLabel = UILabel.init()
        
        imagePreviewView = UIView.init()
        
        linkButton = UIButton.init()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupView()
    }
    
    private func setupView() {
        imagePreviewOne.translatesAutoresizingMaskIntoConstraints = false
        imagePreviewOne.contentMode = .scaleAspectFill
        imagePreviewOne.clipsToBounds = true
        
        imagePreviewTwo.translatesAutoresizingMaskIntoConstraints = false
        imagePreviewTwo.contentMode = .scaleAspectFill
        imagePreviewTwo.clipsToBounds = true
        
        imagePreviewThree.translatesAutoresizingMaskIntoConstraints = false
        imagePreviewThree.contentMode = .scaleAspectFill
        imagePreviewThree.clipsToBounds = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        dateLabel.textColor = UIColor.lightGray
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        
        imagePreviewView.translatesAutoresizingMaskIntoConstraints = false
        imagePreviewView.backgroundColor = UIColor.clear
        
        linkButton.translatesAutoresizingMaskIntoConstraints = false
        linkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        linkButton.setTitleColor(AppTheme.mainColor, for: .normal)
        
        self.separatorInset = UIEdgeInsets.init(top: 0, left: 25, bottom: 0, right: 25)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dateLabel)
        
        NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 15).isActive = true
        NSLayoutConstraint.init(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 25).isActive = true
        NSLayoutConstraint.init(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: -25).isActive = true
        
        NSLayoutConstraint.init(item: dateLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint.init(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: dateLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        
        //Setup image views
        imagePreviewView.addSubview(imagePreviewOne)
        imagePreviewView.addSubview(imagePreviewTwo)
        imagePreviewView.addSubview(imagePreviewThree)
        
        NSLayoutConstraint.init(item: imagePreviewOne, attribute: .top, relatedBy: .equal, toItem: imagePreviewView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewOne, attribute: .leading, relatedBy: .equal, toItem: imagePreviewView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewOne, attribute: .bottom, relatedBy: .equal, toItem: imagePreviewView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewOne, attribute: .height, relatedBy: .equal, toItem: imagePreviewOne, attribute: .width, multiplier: 0.75, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: imagePreviewTwo, attribute: .leading, relatedBy: .equal, toItem: imagePreviewOne, attribute: .trailing, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint.init(item: imagePreviewTwo, attribute: .top, relatedBy: .equal, toItem: imagePreviewOne, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewTwo, attribute: .bottom, relatedBy: .equal, toItem: imagePreviewOne, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewTwo, attribute: .width, relatedBy: .equal, toItem: imagePreviewOne, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        
        NSLayoutConstraint.init(item: imagePreviewThree, attribute: .leading, relatedBy: .equal, toItem: imagePreviewTwo, attribute: .trailing, multiplier: 1.0, constant: 5).isActive = true
        NSLayoutConstraint.init(item: imagePreviewThree, attribute: .top, relatedBy: .equal, toItem: imagePreviewOne, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewThree, attribute: .bottom, relatedBy: .equal, toItem: imagePreviewOne, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewThree, attribute: .width, relatedBy: .equal, toItem: imagePreviewOne, attribute: .width, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imagePreviewThree, attribute: .trailing, relatedBy: .equal, toItem: imagePreviewView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    }
    
    override func prepareForReuse() {
        self.descriptionLabel.removeFromSuperview()
        self.imagePreviewView.removeFromSuperview()
        self.linkButton.removeFromSuperview()
    }
    
    func setupViewWithNewsInfo(_ newsInfo: NewsInfo) {
        
        self.newsInfo = newsInfo
        
        self.titleLabel.text = newsInfo.title
        
        if let validTimestamp = newsInfo.timestamp {
            let date = Formatters.scheduleDateFormatter.date(from: validTimestamp)
            let dateString = Formatters.dayOfWeekMonthDayFormatter.string(from: date!)
            self.dateLabel.text = dateString
        }
        
        var lastView: UIView = dateLabel
        
        if let validDescription = newsInfo.description {
            self.descriptionLabel.text = validDescription
            
            self.contentView.addSubview(self.descriptionLabel)
            NSLayoutConstraint.init(item: descriptionLabel, attribute: .top, relatedBy: .equal, toItem: lastView, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
            NSLayoutConstraint.init(item: descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            
            lastView = descriptionLabel
        }
        
        if newsInfo.images != nil && newsInfo.images!.count > 0{
            self.contentView.addSubview(self.imagePreviewView)
            NSLayoutConstraint.init(item: imagePreviewView, attribute: .top, relatedBy: .equal, toItem: lastView, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
            NSLayoutConstraint.init(item: imagePreviewView, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint.init(item: imagePreviewView, attribute: .trailing, relatedBy: .equal, toItem: titleLabel, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
            
            self.imagePreviewOne!.sd_setImage(with: URL.init(string: newsInfo.images![0]), completed: nil)
            if (newsInfo.images?.count)! > 1 {
                self.imagePreviewTwo.sd_setImage(with: URL.init(string: newsInfo.images![1]), completed: nil)
            }
            if (newsInfo.images?.count)! > 2 {
                self.imagePreviewThree.sd_setImage(with: URL.init(string: newsInfo.images![2]), completed: nil)
            }
            
            let imageCount = newsInfo.images!.count
            
            self.contentView.addSubview(self.linkButton)
            self.linkButton.setTitle(String.init(format: "View %d images", imageCount), for: .normal)
            NSLayoutConstraint.init(item: linkButton, attribute: .top, relatedBy: .equal, toItem: imagePreviewView, attribute: .bottom, multiplier: 1.0, constant: 10).isActive = true
            NSLayoutConstraint.init(item: linkButton, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            
            linkButton.addTarget(self, action: #selector(launchImageViewer), for: .touchUpInside)
            
            lastView = linkButton
        } else if let validLinkInfo = newsInfo.link {
            self.contentView.addSubview(self.linkButton)
            self.linkButton.setTitle(validLinkInfo.title!, for: .normal)
            
            NSLayoutConstraint.init(item: linkButton, attribute: .top, relatedBy: .equal, toItem: lastView, attribute: .bottom, multiplier: 1.0, constant: 5).isActive = true
            NSLayoutConstraint.init(item: linkButton, attribute: .leading, relatedBy: .equal, toItem: titleLabel, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
            
            linkButton.addTarget(self, action: #selector(linkTapped), for: .touchUpInside)
            
            lastView = linkButton
        }
        
        NSLayoutConstraint.init(item: lastView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -15).isActive = true
    }
    
    @objc private func linkTapped() {
        if let linkUrl = self.newsInfo?.link?.url {
            let navController = UINavigationController.init()
            navController.pushViewController(UtilityWebViewController.init(withUrlString: linkUrl), animated: false)
            navController.modalPresentationStyle = .fullScreen
            self.window?.rootViewController?.present(navController, animated: true, completion: nil)
        }
    }
    
    @objc private func launchImageViewer() {
        if let imageUrls = self.newsInfo?.images {
            let navController = UINavigationController.init()
            navController.pushViewController(CustomPhotoViewer.init(imageUrls: imageUrls), animated: false)
            navController.modalPresentationStyle = .fullScreen
            self.window?.rootViewController?.present(navController, animated: true, completion: nil)
        }
    }
}
