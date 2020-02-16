//
//  OasajiViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 11/25/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

public enum MorningServiceType: Int {
    case sofu = 0
    case gyofu
}
class OasajiViewController: UITableViewController {
    
    var serviceType = MorningServiceType.sofu
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(type: MorningServiceType) {
        self.init(nibName: nil, bundle: nil)
        self.serviceType = type
        self.title = "Oasaji (Early Morning Gathering)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.tableView.tableFooterView = UIView.init()
        self.tableView.allowsSelection = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.serviceType {
        case .sofu:
            return "Saturday 7 am - 7:45 am - Redondo"
            break
        case .gyofu:
            return "Sunday 7 am - 7:45 am - Redondo"
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = "Shoshinge​ and ​Wasan (​" + (self.serviceType == .sofu ? "Sofu" : "Gyofu") + " style)"
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "Lead by Rev. Jim Warrick, Ministers, & Ministers Assistants"
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}
