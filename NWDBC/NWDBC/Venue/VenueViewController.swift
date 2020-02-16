//
//  VenueViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/11/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit
import AirshipKit

class VenueViewController: UITableViewController, UARegistrationDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = NSLocalizedString("title.venue", comment: "Venue")
        self.tabBarItem = UITabBarItem.init(title: NSLocalizedString("tabLabel.venue", comment: "Venue"), image: UIImage.init(named: "venue-icon"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(VenueTableViewCell.self, forCellReuseIdentifier: "VenueCell")
        self.tableView.tableFooterView = UIView.init()
        
        UAirship.push()?.registrationDelegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 0 {
             self.navigationController?.pushViewController(HotelMapViewController.init(), animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell") as! VenueTableViewCell
        
        switch indexPath.row {
        case 0:
            return HotelMapTableViewCell.init(style: .default, reuseIdentifier: nil)
            break;
        case 1:
            cell.setTitle("Notifications")
            cell.setSubtitle("Receive updates about schedule changes, event announcements, and other news.")
            
            if UAirship.push()?.userPromptedForNotifications ?? false {
                //User has been asked for push in the past
                var title = "Turn On in Settings"
                if UAirship.push()?.authorizationStatus != nil && UAirship.push()?.authorizationStatus == .authorized {
                    title = "Turn Off in Settings"
                }
                cell.setButtonTitle(title: title) { () -> (Void) in
                    if let url = URL(string: UIApplicationOpenSettingsURLString) {
                        UIApplication.shared.open(url , options: [:], completionHandler: nil)
                    }
                    
                }
            } else {
                cell.setButtonTitle(title: "Send Push Notifications") { () -> (Void) in
                    UAirship.push().userPushNotificationsEnabled = true
                    UAirship.push().notificationOptions = [.alert, .badge, .sound]
                }
            }
            break;
        case 2:
            cell.setTitle("Registration")
            cell.setSubtitle("Badges will be available for pickup starting Friday, February 21st in the Grand Stair Prefunction.\n\nFriday: 7:00 a.m. - 8:30 a.m.\nSaturday: 8:00 a.m. - 8:55 a.m.\n")
        default:
            break;
            
        }
        
        return cell;
    }
    
    // MARK - UARegistrationDelegate Methods
    
    func notificationAuthorizedSettingsDidChange(_ authorizedSettings: UAAuthorizedNotificationSettings) {
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }
    }
    
}
