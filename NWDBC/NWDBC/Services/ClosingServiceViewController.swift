//
//  ClosingServiceViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 11/25/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ClosingServiceViewController: UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Closing Service"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.tableView.tableFooterView = UIView.init()
        
        self.tableView.register(DisclosureTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sunday 10 am - DoubleTree Ballroom"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DisclosureTableViewCell
        
        var titleText = ""
        var subtitleText = ""
        
        
        switch indexPath.row {
        case 0:
            titleText = "Kansho, Calling Bell"
            subtitleText = "Ruth Terry"
            break
        case 1:
            titleText = "Opening Remarks"
            subtitleText = "Char Grinolds, Chairperson"
            break
        case 2:
            titleText = "Opening Meditation"
            subtitleText = "Rev. Takashi Miyaji"
            break
        case 3:
            titleText = "Sutra Chanting - \"Sanbutsuge\""
            subtitleText = "Rev. Kodo Umezu, Bishop"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 4:
            titleText = "Closing Keynote Address"
            subtitleText = "Rev. Matthew Hamasaki"
            break
        case 5:
            titleText = "Closing Meditation"
            subtitleText = "Rev. Jerry Hirano"
            break
        case 6:
            titleText = "Invitation to World BWA Convention"
            subtitleText = "Janet Umezu and Susan Bottari"
            break
        case 7:
            titleText = "IBS Program Update"
            subtitleText = "Landon Yamaoka"
            break
        case 8:
            titleText = "Installation of Officers"
            subtitleText = "Rev. Kodo Umezu, Bishop"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 9:
            titleText = "Appreciation"
            subtitleText = "Convention Co-Chairs"
            break
        case 10:
            titleText = "Closing Remarks"
            subtitleText = "Convention Co-Chairpersons"
            break
        case 11:
            titleText = "Announcements"
            subtitleText = "Char Grinolds"
            break
        default:
            break
        }
        
        cell.textLabel?.text = titleText
        cell.detailTextLabel?.text = subtitleText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 3:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("Sanbutsuge", text: NSLocalizedString("sanbutsuge", comment: "Sanbutsuge"))
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case 8:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("Installation of Officers", text: NSLocalizedString("closingService.installationOfOfficers", comment: "Installation of Officers"))
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        default:
            break
        }
    }
}
