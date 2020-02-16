//
//  BanquetViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 11/20/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class BanquetViewController: UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Banquet"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.tableView.register(SubtitleTableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.allowsSelection = false
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 13
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Saturday 6 PM - 8 PM DoubleTree Ballroom"
        case 1:
            return "Entertainment 8 PM - 9:30 PM"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        var titleText = ""
        var subtitleText = ""
        
        switch (indexPath.section, indexPath.row) {
           case (0,0):
                 titleText = "Masters of Ceremonies"
                 subtitleText = "Jason, Curtis & Trevor Yokoyama"
                 break
             case (0,1):
                 titleText = "Opening Remarks"
                 subtitleText = "Trevor Yokoyama"
                 break
             case (0,2):
                 titleText = "Introduction of Guests"
                 subtitleText = "Jason Yokoyama"
                 break
             case (0,3):
                 titleText = "Sokuzen No Kotoba - Words before the meal"
                 subtitleText = "Rev. Jerry Hirano"
                 break
             case (0,4):
                 titleText = "Banquet Dinner"
                 break
             case (0,5):
                 titleText = "Shokugo No Kotoba - Words after the meal"
                 subtitleText = "Rev. Jim Warrick"
                 break
             case (0,6):
                 titleText = "New Kaikyoshi Presentations"
                 subtitleText = "Bishop Kodo Umezu\nTom Nishikawa, Western Adult Buddhist League\nElaine Donlin, Federation of Buddhist Women's Associations"
                 break
             case (0,7):
                 titleText = "Message"
                 subtitleText = "Bishop Kodo Umezu"
                 break
             case (0,8):
                 titleText = "Presentation to representatives of Hawaii Kyodan & Jodo Shinshu Buddhist Temples of Canada"
                 subtitleText = "Mr. Rick Stambul, BCA President"
                 break
             case (0,9):
                 titleText = "Zaidan Collection"
                 subtitleText = "Koichi Sayano"
                 break
             case (0,10):
                titleText = "Message"
                subtitleText = "Mr. Rick Stambul, BCA President"
                break
            case (0,11):
                titleText = "Words of Appreciation"
                subtitleText = "Dr. Kent Matsuda, BCA President Elect"
                break
            case (0,12):
                titleText = "2021 National Council Meeting"
                subtitleText = "Bay District Planning Commitee"
                break
            case (0,13):
                titleText = "2021 NorthWest District Convention"
                subtitleText = "Oregon Buddhist Temple"
                break
            case (1,0):
                titleText = "Entertainment"
                subtitleText = ""
                break
        default:
            break
        }
        
        cell.textLabel?.text = titleText
        cell.detailTextLabel?.text = subtitleText
        
        return cell
    }
}
