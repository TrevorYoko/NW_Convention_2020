//
//  AboutViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/10/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

private enum AboutRows: Int {
    case privacy = 0
    case termsOfUse
    case icons
    case lastValue
}

class AboutViewController: UITableViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "About"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        self.tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.tableFooterView = UIView.init()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AboutRows.lastValue.rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case AboutRows.privacy.rawValue:
            cell.textLabel?.text = "Privacy Policy"
            break
        case AboutRows.termsOfUse.rawValue:
            cell.textLabel?.text = "Terms Of Use"
            break
        case AboutRows.icons.rawValue:
            cell.textLabel?.text = "Icons8"
            cell.detailTextLabel?.text = "Provided icons for the app"
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case AboutRows.privacy.rawValue:
            let navController = UINavigationController.init()
            navController.pushViewController(UtilityWebViewController.init(withUrlString: "https://wrbt.org/privacy"), animated: false)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            break
        case AboutRows.termsOfUse.rawValue:
            let navController = UINavigationController.init()
            navController.pushViewController(UtilityWebViewController.init(withUrlString: "https://wrbt.org/terms"), animated: false)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            break
        case AboutRows.icons.rawValue:
            let navController = UINavigationController.init()
            navController.pushViewController(UtilityWebViewController.init(withUrlString: "https://icons8.com"), animated: false)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            break
        default:
            break
        }
    }
}

