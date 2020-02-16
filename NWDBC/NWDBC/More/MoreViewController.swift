//
//  MoreViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/11/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

private enum MoreRows: Int {
    case about = 0
    case donations
    case conventionBoosters
    case committee
    case advertisements
    case lastValue
}

class MoreViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = NSLocalizedString("title.more", comment: "More")
        self.tabBarItem = UITabBarItem.init(title: NSLocalizedString("tabLabel.more", comment: "More"), image: UIImage.init(named: "more-icon"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.tableFooterView = UIView.init()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoreRows.lastValue.rawValue
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case MoreRows.about.rawValue:
            cell.textLabel?.text = "About"
            break
        case MoreRows.donations.rawValue:
            cell.textLabel?.text = "Donors"
            break
        case MoreRows.conventionBoosters.rawValue:
            cell.textLabel?.text = "Convention Boosters"
            break
        case MoreRows.committee.rawValue:
            cell.textLabel?.text = "Convention Committee"
            break
        case MoreRows.advertisements.rawValue:
            cell.textLabel?.text = "Advertisements"
            break
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch indexPath.row {
        case MoreRows.about.rawValue:
            self.navigationController?.pushViewController(AboutViewController.init(), animated: true)
            break
        case MoreRows.donations.rawValue:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("Donors", text: NSLocalizedString("donors", comment: "Convention Donors"), alignment: .center)
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case MoreRows.conventionBoosters.rawValue:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("Convention Boosters", text: NSLocalizedString("conventionBoosters", comment: "Convention Boosters"), alignment: .center)
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case MoreRows.committee.rawValue:
            self.navigationController?.pushViewController(CommitteeViewController.init(), animated: true)
            break
        case MoreRows.advertisements.rawValue:
            let path = Bundle.main.path(forResource: "Advertisements", ofType: "pdf")!
            let documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: path))
            documentController.delegate = self
            documentController.presentPreview(animated: true)
            break
        default:
            break
        }
    }
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
