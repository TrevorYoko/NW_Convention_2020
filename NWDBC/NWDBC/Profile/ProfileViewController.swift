//
//  ProfileViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/14/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit
import Pulley

class ProfileViewController: UIViewController {
    var speakerInfo: SpeakerInfo!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(speakerInfo: SpeakerInfo) {
        self.init(nibName: nil, bundle: nil)
        
        self.speakerInfo = speakerInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        let tabOffsetBottom = self.tabBarController?.tabBar.bounds.size.height
        
        let profileInfoVC = ProfileInfoViewController.init(speakerInfo: speakerInfo, offsetBottom: tabOffsetBottom!)
        let offsetTop = (self.navigationController?.navigationBar.frame.origin.y ?? 0) + 44
        var offsetBottom = profileInfoVC.collapsedDrawerHeight(bottomSafeArea: 0)
        if offsetBottom > 150 {
            offsetBottom = offsetBottom - (self.tabBarController?.tabBar.frame.height ?? 0)
        }
        
        let pulleyVC = PulleyViewController.init(contentViewController: ProfileImageViewController.init(speakerInfo: speakerInfo, offsetTop: offsetTop, offsetBottom: offsetBottom), drawerViewController: profileInfoVC)
        
        pulleyVC.willMove(toParentViewController: self)
        self.addChildViewController(pulleyVC)
        self.view.addSubview(pulleyVC.view)
        pulleyVC.didMove(toParentViewController: self)
        
    }
    
}
