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
                      subtitleText = "Charlene Grinolds, Leanne Nishi-Wong, Alan Hoshino"
                      break
                  case 1:
                      titleText = "Advisor"
                      subtitleText = "Rev. Katsuya Kusunoki"
                      break
                  case 2:
                      titleText = "Banquet Centerpieces"
                      subtitleText = "Susie Taketa, Julianne Tosaya"
                      break
                  case 3:
                      titleText = "Banquet Program"
                      subtitleText = "Jason, Curtis and Trevor Yokoyama"
                      break
                  case 4:
                      titleText = "Dharma School"
                      subtitleText = "Yvette Terada, Erin Taylor"
                      break
                  case 5:
                      titleText = "Entertainment"
                      subtitleText = "Connie Ozeki-Chinn, Tara Tamaribuchi-Gibbs"
                      break
                  case 6:
                      titleText = "Equipment Transportation"
                      subtitleText = "Gary Shibata, Craig Nakashima"
                      break
                  case 7:
                      titleText = "Hospitality"
                      subtitleText = "Joan Nakano, Marie Kosai-Luke"
                     break
                 case 8:
                     titleText = "Hotel Coordinator"
                     subtitleText = "Alan Hoshino"
                     break
                 case 9:
                     titleText = "Meals"
                     subtitleText = "Alan Hoshino"
                     break
                 case 10:
                     titleText = "Mobile App"
                     subtitleText = "Evan Ko, Bryce Matsuda, Curtis Yokoyama, Trevor Yokoyama, Curtis Yamanaka"
                 case 11:
                     titleText = "Program Booklet Design"
                     subtitleText = "Kendall Kosai"
                     break
                 case 12:
                     titleText = "Program Booklet Artwork"
                     subtitleText = "Alex Sakamoto"
                     break
                 case 13:
                     titleText = "Programming"
                     subtitleText = "Connor McKinney, Dean O'Shields, Emily Ko, Evan Ko"
                     break
                 case 14:
                     titleText = "Registration"
                     subtitleText = "Marie Kosai-Luke, Steph Ojima"
                     break
                 case 15:
                     titleText = "Services"
                     subtitleText = "Rev. Katsuya Kusunoki"
                     break
                 case 16:
                     titleText = "Social Media"
                     subtitleText = "Alex Sakamoto"
                     break
                 case 17:
                     titleText = "Sponsorship"
                     subtitleText = "Karen and Yukio Morikubo"
                     break
                 case 18:
                     titleText = "Graphic Support"
                     subtitleText = "Yoko Yanari"
                     break
                 case 19:
                     titleText = "Music"
                     subtitleText = "Kemi Nakabayashi"
                     break
                 case 20:
                     titleText = "Transportation"
                     subtitleText = "Sam Umeda"
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

