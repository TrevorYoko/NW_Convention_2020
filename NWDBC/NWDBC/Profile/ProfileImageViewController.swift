//
//  ProfileImageViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 1/29/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ProfileImageViewController: UIViewController {
    var speakerInfo: SpeakerInfo!
    var offsetTop: CGFloat!
    var offsetBottom: CGFloat!

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(speakerInfo: SpeakerInfo, offsetTop: CGFloat, offsetBottom: CGFloat) {
        self.init(nibName: nil, bundle: nil)
        
        self.speakerInfo = speakerInfo
        self.offsetTop = offsetTop
        self.offsetBottom = offsetBottom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageName = self.speakerInfo.secondaryImage != nil ? self.speakerInfo.secondaryImage : self.speakerInfo.image
        let image = UIImage.init(named: imageName!)
        
        let imageView = UIImageView.init(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        self.view.addSubview(imageView)
        NSLayoutConstraint.init(item: imageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: offsetTop).isActive = true
        NSLayoutConstraint.init(item: imageView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint.init(item: imageView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
       NSLayoutConstraint.init(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -offsetBottom).isActive = true
    }
}
