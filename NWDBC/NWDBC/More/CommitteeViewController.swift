//
//  CommitteeViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/9/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import UIKit

class CommitteeViewController : UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "73rd NW Buddhist Convention"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 19
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Convention Committee"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "Cell")
        cell.selectionStyle = .none
        
        var titleText = ""
        var subtitleText = ""
        
        
        switch indexPath.row {
        case 0:
            titleText = "Convention Co-Chairs"
            subtitleText = "Charlene Grinolds, Sharon Kosai, Valerie Yamanaka"
            break
        case 1:
            titleText = "Advisor"
            subtitleText = "Rev. Jim Warrick"
            break
        case 2:
            titleText = "Banquet Centerpieces"
            subtitleText = "Barbara Akiyama"
            break
        case 3:
            titleText = "Banquet Program"
            subtitleText = "Valerie Yamanaka"
            break
        case 4:
            titleText = "Dharma School"
            subtitleText = "Rona Warrick"
            break
        case 5:
            titleText = "Entertainment"
            subtitleText = "Don & Judy Gardner, Reese Morikubo"
            break
        case 6:
            titleText = "Equipment Transportation"
            subtitleText = "Charles Natsuhara"
            break
        case 7:
            titleText = "Hospitality"
            subtitleText = "Alva Nishimura, Curtis Yamanaka"
            break
        case 8:
            titleText = "Hotel Coordinator"
            subtitleText = "Charlene Grinolds"
            break
        case 9:
            titleText = "Meals"
            subtitleText = "Shirley Kanda, Kathryn Natsuhara"
            break
        case 10:
            titleText = "Mobile App"
            subtitleText = "Curtis Yamanaka"
        case 11:
            titleText = "Program Booklet Design"
            subtitleText = "Kendall Kosai, Sharon Kosai, Valerie Yamanaka"
            break
        case 12:
            titleText = "Program Booklet Artwork"
            subtitleText = "Tessa Asato"
            break
        case 13:
            titleText = "Programming"
            subtitleText = "Charlene Grinolds, Rev. Jim Warrick, Valerie Yamanaka"
            break
        case 14:
            titleText = "Registration"
            subtitleText = "Kelsey Asato"
            break
        case 15:
            titleText = "Schedule"
            subtitleText = "Kendall Kosai, Sharon Kosai"
            break
        case 16:
            titleText = "Services"
            subtitleText = "Ron Murakami, Rev. Jim Warrick"
            break
        case 17:
            titleText = "Social Media"
            subtitleText = "Tessa Asato"
            break
        case 18:
            titleText = "Sponsorship"
            subtitleText = "Kendall Kosai"
            break
        default:
            break
        }
        
        cell.textLabel?.text = titleText
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = subtitleText
        cell.detailTextLabel?.numberOfLines = 0
        
        return cell
    }
}

