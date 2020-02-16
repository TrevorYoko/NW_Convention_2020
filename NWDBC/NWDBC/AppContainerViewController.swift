//
//  AppContainerViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/10/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit
import AirshipKit

class AppContainerViewController: UITabBarController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        let homeViewController = HomeViewController.init()
        let homeNavController = UINavigationController.init(rootViewController: homeViewController)
        homeNavController.tabBarItem = homeNavController.tabBarItem
        homeNavController.navigationBar.prefersLargeTitles = true

        let scheduleLandingViewController = ScheduleLandingViewController.init()
        let scheduleNavController = UINavigationController.init(rootViewController: scheduleLandingViewController)
        scheduleNavController.tabBarItem = scheduleLandingViewController.tabBarItem
        scheduleNavController.navigationBar.prefersLargeTitles = true
        
        let newsViewController = NewsViewController.init()
        let newsNavController = UINavigationController.init(rootViewController: newsViewController)
        newsNavController.tabBarItem = newsViewController.tabBarItem
        newsNavController.navigationBar.prefersLargeTitles = true
        
        let venueViewController = VenueViewController.init()
        let venueNavController = UINavigationController.init(rootViewController: venueViewController)
        venueNavController.tabBarItem = venueViewController.tabBarItem
        venueNavController.navigationBar.prefersLargeTitles = true
        
        let moreViewController = MoreViewController.init()
        let moreNavController = UINavigationController.init(rootViewController: moreViewController)
        moreNavController.tabBarItem = moreViewController.tabBarItem
        moreNavController.navigationBar.prefersLargeTitles = true
        
        self.viewControllers = [homeNavController, scheduleNavController, newsNavController, venueNavController, moreNavController]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UAirship.push().notificationOptions = [.provisional, .alert, .badge, .sound]
        UAirship.push().userPushNotificationsEnabled = true
    }
}


