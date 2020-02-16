//
//  BCANCOpeningServiceViewController.swift
//  NWDBC
//
//  Created by Curtis Yokoyama on 2/16/20.
//  Copyright © 2020 Curtis Yamanaka. All rights reserved.
//
// use Id: 23

import UIKit
class BCANCOpeningServiceViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Friday Morning Service: BCA National Council Opening Service"
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
        return 11
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Friday 8:30 am - Grand Ballrooom (First Floor)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DisclosureTableViewCell
        
        var titleText = ""
        var subtitleText = ""
        
        
        switch indexPath.row {
        case 0:
            titleText = "Chosho"
            subtitleText = "Rev. Kodo Umezu, Bishop"
            break
        case 1:
            titleText = "Chairperson"
            subtitleText = "Rev. Jerry Hirano"
            break
        case 2:
            titleText = "Individual incense burning"
            subtitleText = "by All"
            break
        case 3:
            titleText = "Opening Remarks"
            subtitleText = "Rev. Jerry Hirano, Chairperson"
            break
        case 4:
            titleText = "Chanting"
            subtitleText = "Juseige"
            break
        case 5:
            titleText = "Incense Burning by Representatives"
            subtitleText = "Bay District\nCentral California District\nCoast District\nEastern District\nMountain States District\nSouthern District\nHonpa Hongwanji Mission of Hawaii\nJodo Shinshu Buddhist Temples of Canada\nBCA Ministers Association\nBuddhist Churches of America\nNorthwestDistrict"
            break
        case 6:
            titleText = "Our Pledge"
            subtitleText = "Rev. Yuki Sugahara"
            break
        case 7:
            titleText = "Bishop's Message"
            subtitleText = "Rev. Kodo Umezu, Bishop"
            break
        case 8:
            titleText = "Gatha"
            subtitleText = "Ondokusan 1"
            break
        case 9:
            titleText = "Welcome & Announcement"
            subtitleText = "Convention Co-Chairs"
            break
        case 10:
            titleText = "Closing Remarks"
            subtitleText = "Chairperson"
            break

        default:
            break
        }
        
        cell.textLabel?.text = titleText
        cell.detailTextLabel?.text = subtitleText
        
        return cell
    }
    
    
    // MARK - UIDocumentInteractionControllerDelegate Methods
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}

