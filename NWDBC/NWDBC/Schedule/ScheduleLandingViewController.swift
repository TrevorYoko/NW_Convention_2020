//
//  ScheduleLandingViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/10/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

private enum ScheduleRows: Int {
    case activitiesWorkshopsTitle = 0
    case activitiesWorkshopsDescription
    case serviceTitle
    case serviceDescription
    case banquetTitle
    case banquetDescription
}

class ScheduleLandingViewController: UITableViewController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        self.title = NSLocalizedString("title.schedule", comment: "Schedule")
        self.tabBarItem = UITabBarItem.init(title:  NSLocalizedString("tabLabel.schedule", comment: "Schedule"), image: UIImage.init(named: "calendar-icon"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell")
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: "TitleCell")
                cell!.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
                cell!.selectionStyle = .none
                
                let button = UIButton.init(frame: CGRect.zero)
                button.setTitle("See All", for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                button.setTitleColor(AppTheme.mainColor, for: .normal)
                button.sizeToFit()
                button.isUserInteractionEnabled = false
                cell!.accessoryView = button
                
                let separator = UIView.init()
                separator.frame = CGRect.init(x: 15, y: cell!.bounds.size.height - 1 , width: cell!.bounds.size.width - 15, height: 1)
                separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
                separator.backgroundColor = UIColor.init(red: 232.0/255.0, green: 232.0/255.0, blue: 234.0/255.0, alpha: 1.0)
                cell?.addSubview(separator)
            }
            
            setupTitleCell(cell!, forRowAt: indexPath)
            
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell")
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: "DetailsCell")
                cell!.textLabel?.font = UIFont.systemFont(ofSize: 14)
                cell!.textLabel?.textColor = UIColor.lightGray
                cell!.textLabel?.numberOfLines = 0
                cell!.selectionStyle = .none
            }
            
            setupDescriptionCell(cell!, forRowAt: indexPath)
            
            return cell!
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case ScheduleRows.activitiesWorkshopsTitle.rawValue:
            self.navigationController?.pushViewController(ScheduleViewController.init(), animated: true)
            break
        case ScheduleRows.serviceTitle.rawValue:
            self.navigationController?.pushViewController(ServiceScheduleViewController.init(), animated: true)
            break
        case ScheduleRows.banquetTitle.rawValue:
            self.navigationController?.pushViewController(BanquetViewController.init(), animated: true)
            break
        default:
            break
        }
    }
    
    private func setupTitleCell(_ cell: UITableViewCell, forRowAt indexPath:IndexPath) {
        switch indexPath.row {
        case ScheduleRows.activitiesWorkshopsTitle.rawValue:
            cell.textLabel?.text = "Activities & Workshops"
            break
        case ScheduleRows.serviceTitle.rawValue:
            cell.textLabel?.text = "Services"
            break
        case ScheduleRows.banquetTitle.rawValue:
            cell.textLabel?.text = "Banquet"
            break
        default:
            break
        }
    }
    
    private func setupDescriptionCell(_ cell: UITableViewCell, forRowAt indexPath:IndexPath) {
        switch indexPath.row {
        case ScheduleRows.activitiesWorkshopsDescription.rawValue:
            cell.textLabel?.text =  "View all the activities and workshops for this years convention. See where everything is happening and who is teaching each workshop."
            break
        case ScheduleRows.serviceDescription.rawValue:
            cell.textLabel?.text =  "View the schedule for morning and closing service."
            break
        case ScheduleRows.banquetDescription.rawValue:
            cell.textLabel?.text = "View the schedule for Saturday's banquet."
            break
        default:
            break
        }
    }
}

