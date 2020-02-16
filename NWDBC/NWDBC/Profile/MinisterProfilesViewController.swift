//
//  MinisterProfilesViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/14/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class MinisterProfilesViewController: UITableViewController {
    
    let speakerManager = SpeakerManager.sharedInstance
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Ministers & Speakers"
        self.tabBarItem = UITabBarItem.init(title: "Speakers", image: UIImage.init(named: "speaker"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(ProfileTableviewCell.self, forCellReuseIdentifier: "ProfileCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.speakerManager.numberOfSpeakers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ProfileTableviewCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileTableviewCell
    
        
        guard let speakerInfo = speakerManager.speakerInfoAtIndex(indexPath.row) else { return cell }
        
        cell.setupViewWithSpeakerInfo(speakerInfo)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let speakerInfo = speakerManager.speakerInfoAtIndex(indexPath.row) else { return }
        
        self.navigationController?.pushViewController(ProfileViewController.init(speakerInfo: speakerInfo), animated: true)
    }
}
