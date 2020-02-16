//
//  OpeningServiceViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 1/16/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit
class OpeningServiceViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Opening Service"
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
        return 15
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Saturday 9:30 am - DoubleTree Ballroom"
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
            titleText = "Processional"
            subtitleText = "Ministers"
            break
        case 2:
            titleText = "Opening Remarks"
            subtitleText = "Sharon Kosai, Chairperson"
            break
        case 3:
            titleText = "Opening Meditation"
            subtitleText = "Rev. Katsuya Kusunoki"
            break
        case 4:
            titleText = "Welcome Message"
            subtitleText = "Valerie Yamanaka, Convention Co-Chair"
            break
        case 5:
            titleText = "Daihyo Oshoko"
            subtitleText = "Temple Representatives"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 6:
            titleText = "Sutra Chanting - \"Juseige\""
            subtitleText = "Rev. Kodo Umezu, Bishop"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 7:
            titleText = "The Three Treasures"
            subtitleText = "Rev. Jim Warrick"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 8:
            titleText = "Gatha - Ondokusan II"
            subtitleText = "All"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 9:
            titleText = "Closing Meditation"
            subtitleText = "Rev. Yuki Sugahara"
            break
        case 10:
            titleText = "Recessional"
            subtitleText = "Ministers"
            break
        case 11:
            titleText = "Dharma School Students Dismissed"
            subtitleText = "*Parents/Guardians - Please escort your children to the Rainer Room"
            break
        case 12:
            titleText = "Introduction of Guests"
            subtitleText = "Sharon Kosai"
            break
        case 13:
            titleText = "Keynote Address - Compassion, Gratitude, Community"
            subtitleText = "Rev. Matthew Hamasaki"
            break
        case 14:
            titleText = "Closing Remarks/Announcements"
            subtitleText = "Sharon Kosai"
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
        case 5:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("Daihyo Oshoko", text: NSLocalizedString("openingService.templeRepresentatives", comment: "Temple Representatives"))
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case 6:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("Juseige", text: NSLocalizedString("juseige", comment: "Juseige"))
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case 7:
            let viewController = TextViewDetailsViewController.init()
            viewController.setupViewController("The Three Treasures", text: NSLocalizedString("threeTreasures", comment: "The Three Treasures"))
            self.navigationController?.pushViewController(viewController, animated: true)
            break
        case 8:
            let path = Bundle.main.path(forResource: "Ondokusan", ofType: "pdf")!
            let documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: path))
            documentController.delegate = self
            documentController.presentPreview(animated: true)
            break
        default:
            break
        }
    }
    
    // MARK - UIDocumentInteractionControllerDelegate Methods
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
