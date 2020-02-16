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
            titleText = "Welcome and Introductions"
            subtitleText = "Melissa Ong"
            break
        case (0,1):
            titleText = "Sokuzen No Kotoba - Words before the meal"
            subtitleText = "Rev. Don Castro"
            break
        case (0,2):
            titleText = "Banquet Dinner"
            break
        case (0,3):
            titleText = "Shokugo No Kotoba - Words after the meal"
            subtitleText = "Rev. Kosho Yukawa"
            break
        case (0,4):
            titleText = "Introduction of BCA President"
            subtitleText = "Melissa Ong"
            break
        case (0,5):
            titleText = "Greetings from BCA President"
            subtitleText = "Mr. Rick Stambul"
            break
        case (0,6):
            titleText = "Zaidan Offering"
            break
        case (0,7):
            titleText = "Introduction of NWDC President"
            subtitleText = "Melissa Ong"
            break
        case (0,8):
            titleText = "NWD Minister Recognition"
            subtitleText = "John Inge"
            break
        case (0,9):
            titleText = "Introduction of Speaker"
            subtitleText = "Melissa Ong"
            break
        case (0,10):
            titleText = "Banquet Keynote Address"
            subtitleText = "Rev. Ann Spencer"
            break
        case (0,11):
            titleText = "2020 Convention Hosts"
            subtitleText = "Seattle Betsuin Buddhist Temple"
            break
        case (0,12):
            titleText = "Announcements"
            break
        case (1,0):
            titleText = "Variety Show"
            subtitleText = "This year's variety show is packed with games, trivia, and much more. Stick around and you might find yourself competing head-to-head against Sensei Matt in a race against time!"
            break
        default:
            break
        }
        
        cell.textLabel?.text = titleText
        cell.detailTextLabel?.text = subtitleText
        
        return cell
    }
}
