//
//  BCAMinistrersServiceViewController.swift
//  NWDBC
//
//  Created by Curtis Yokoyama on 2/16/20.
//  Copyright © 2020 Curtis Yamanaka. All rights reserved.
//
// Use Id: 4

import UIKit
class BCAMinistrersServiceViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Wednesday Morning Service: BCA Ministers Association Opening Service"
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
        return 9
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Wednesday 9:30 am - Bellevue II"
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
            subtitleText = "Rev. Katsuya Kusunoki"
            break
        case 2:
            titleText = "Opening Remarks"
            subtitleText = "Rev. Katsuya Kusunoki, Chairperson"
            break
        case 3:
            titleText = "Chanting"
            subtitleText = "Chikai no Uta"
            break
        case 4:
            titleText = "Our Pledge"
            subtitleText = "Rev. Takashi Miyaji"
            break
        case 5:
            titleText = "Dharma Message"
            subtitleText = "Rev. Etsuko Mikame"
            break
        case 6:
            titleText = "Bishop's Message"
            subtitleText = "Rev. Kodo Umezu, Bishop"
            break
        case 7:
            titleText = "Announcements"
            subtitleText = "Convention Co-Chairs"
            break
        case 8:
            titleText = "Closing Remarks"
            subtitleText = "Rev. Katsuya Kusunoki, Chairperson"
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
