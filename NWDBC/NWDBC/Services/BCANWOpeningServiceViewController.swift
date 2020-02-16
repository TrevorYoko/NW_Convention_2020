//
//  BCANWOpeningServiceViewController.swift
//  NWDBC
//
//  Created by Curtis Yokoyama on 2/16/20.
//  Copyright © 2020 Curtis Yamanaka. All rights reserved.
//
// Use Id : 43

import UIKit
class BCANWOpeningServiceViewController: UITableViewController, UIDocumentInteractionControllerDelegate {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Saturday Morning Service: BCA National Council Morning Service & NW Convention Opening Service"
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
        return "Saturday 9:30 am - Grand Ballroom (First Floor)"
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
            subtitleText = "Emily Ko, Young Adult Ministers' Assistant"
            break
        case 2:
            titleText = "Individual Incense Burning before Service"
            subtitleText = "by All"
            break
        case 3:
            titleText = "Opening Remarks"
            subtitleText = "Emily Ko, Young Audlt Ministers' Assistant"
            break
        case 4:
            titleText = "Chanting"
            subtitleText = "Juseige -Music Service Version- & Eko \"Ondokusan II\""
            cell.showCustomAccessory(shouldShow: true)
            break
        case 5:
            titleText = "Incense Burning by Representatives"
            subtitleText = "Buddhist Churches of America\nNW Ministers Association\nNW District Council\nNW Buddhist Women's Association\nNW Dharma School Teachers League\nNW Young Buddhist League\nNW Sr. YBA\nNW Young Adult Buddhist Association\nIdaho-Oregon Buddhist Temple\nOregon Buddhist Temple\nSpokane Buddhist Temple\nTacoma Buddhist Temple\nWhite River Buddhist Temple\nYakima Buddhist Temple (including Columbia Basin Sangha)\nSeattle Betsuin Buddhist Temple"
            break
        case 6:
            titleText = "Gatha"
            subtitleText = "\"Dana for World Peace\" by Northwest District Singers"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 7:
            titleText = "The Threefold Refuge"
            subtitleText = "Rev. Jim Warrick"
            cell.showCustomAccessory(shouldShow: true)
            break
        case 8:
            titleText = "Dharma Message"
            subtitleText = "Rev. Kory Quon"
            break
        case 9:
            titleText = "Special Presentation"
            subtitleText = "Rev. Kiyonobu Kuwahara"
            break
        case 10:
            titleText = "Gatha"
            subtitleText = "\"Gasho 'Round the World'\" accompanied by the Seattle Betsuin Ukulele Band"
            break
        case 11:
            titleText = "Dharma School Students Dismissed"
            subtitleText = "*Parents/Guardians - Please escort your children to the Rainer Room"
            break
        case 12:
            titleText = "NW Special Recognition"
            break
        case 13:
            titleText = "Welcome & Announcement"
            subtitleText = "Convention Co-Chairs"
            break
        case 14:
            titleText = "Closing Remarks"
            subtitleText = "Emily Ko, Young Adult Ministers' Assistant"
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
        case 4: // Musical Juseige PDF
            let path = Bundle.main.path(forResource: "Ondokusan", ofType: "pdf")!
            let documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: path))
            documentController.delegate = self
            documentController.presentPreview(animated: true)
            break
        case 6: // Dana for World Peace PDF
            let path = Bundle.main.path(forResource: "Ondokusan", ofType: "pdf")!
            let documentController = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: path))
            documentController.delegate = self
            documentController.presentPreview(animated: true)
            break
        case 10: // Gassho Around the World PDF
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
