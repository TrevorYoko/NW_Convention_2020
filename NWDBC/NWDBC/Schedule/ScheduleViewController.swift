//
//  ScheduleViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/10/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let eventManager = EventManager.sharedInstance
    let roomManager = EventRoomsManager.sharedInstance
    var setupForWorkshop = false
    
    var tableView: UITableView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Activities & Workshops"
        self.tabBarItem = UITabBarItem.init(title:  NSLocalizedString("tabLabel.schedule", comment: "Schedule"), image: nil, tag: 1)
    }
    
    convenience init(isWorkshops: Bool) {
        self.init()
    
        setupForWorkshop = isWorkshops
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        let toolbar = UIToolbar.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: 44))
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toolbar)
        let guide = self.view.safeAreaLayoutGuide
        toolbar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        toolbar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        toolbar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        
        let segmentControl = UISegmentedControl.init()
        segmentControl.insertSegment(withTitle: "All", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Activities", at: 1, animated: false)
        segmentControl.insertSegment(withTitle: "Workshops", at: 2, animated: false)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(filterChanged(_:)), for: .valueChanged)
        toolbar.items = [UIBarButtonItem.init(customView: segmentControl)]
        
        if self.setupForWorkshop {
            segmentControl.selectedSegmentIndex = 2
            self.eventManager.applyWorkshopFilter()
        } else {
            self.eventManager.applyNoFilter()
        }
        
        let tableView = UITableView.init()
        self.tableView = tableView
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        var constraints: [NSLayoutConstraint] = []
        constraints.append(NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: toolbar, attribute: .bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0))
        constraints.append(NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0))
        self.view.addConstraints(constraints)
        
        self.tableView?.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    @objc private func filterChanged(_ segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.eventManager.applyNoFilter()
            break
        case 1:
            self.eventManager.applyActivityFilter()
            break
        case 2:
            self.eventManager.applyWorkshopFilter()
            break
        default:
            break
        }
        
        self.tableView?.reloadData()
        self.tableView?.scrollToRow(at: IndexPath.init(item: 0, section: 0), at: .top, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventManager.numberOfGroups()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventManager.numberOfEventsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let date = self.eventManager.dateForSection(section) {
            let dateString = Formatters.dayTimeFormatter.string(from: date)
            return dateString.uppercased()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let eventInfo = self.eventManager.getEventAtIndexPath(indexPath) else { return }
        self.navigationController?.pushViewController(EventActivityViewController.init(eventInfo: eventInfo), animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ScheduleTableViewCell
        
        guard let eventInfo = self.eventManager.getEventAtIndexPath(indexPath) else {return cell}
        cell.textLabel?.text = eventInfo.title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.separatorInset = UIEdgeInsets.zero
        
        if let type = eventInfo.type {
            switch type {
            case 0:
                //Nothing
                cell.setColor(color: UIColor.white)
                break
            case 1:
                //Activities
                cell.setColor(color: UIColor.init(red: 243/255, green: 184/255, blue: 97/255, alpha: 1.0))
                break
            case 2, 6:
                //Service
                cell.setColor(color: UIColor.init(red: 131/255, green: 194/255, blue: 233/255, alpha: 1.0))
                break
            case 3:
                //Workshop
                cell.setColor(color: UIColor.init(red: 155/255, green: 198/255, blue: 126/255, alpha: 1.0))
                break
            case 4:
                //Keynote
                cell.setColor(color: UIColor.init(red: 166/255, green: 141/255, blue: 189/255, alpha: 1.0))
                break
            case 5:
                //Meetings
                cell.setColor(color: UIColor.init(red: 254/255, green: 163/255, blue: 170/255, alpha: 1.0))
                break
            default:
                cell.setColor(color: UIColor.white)
                break
            }
        }
        
        if let roomIds = eventInfo.roomIds {
            var roomNameString = ""
            
            for i in 0..<roomIds.count {
                roomNameString.append(self.roomManager.getRoomNameWithId(roomIds[i]))
                if i < roomIds.count - 1 {
                    roomNameString.append("/")
                }
            }
            
            
            var timeString = ""
            if let startString = eventInfo.startTime, let endString = eventInfo.endTime {
                let startDate = Formatters.scheduleDateFormatter.date(from: startString)
                let endDate = Formatters.scheduleDateFormatter.date(from: endString)
                
                let startAMPM = Formatters.ampmFormatter.string(from: startDate!)
                let endAMPM = Formatters.ampmFormatter.string(from: endDate!)
                
                if startAMPM == endAMPM {
                    timeString = Formatters.timeWithoutAMPMFormatter.string(from: startDate!) + " - " + Formatters.timeWithAMPMFormatter.string(from: endDate!)
                } else {
                    timeString = Formatters.timeWithAMPMFormatter.string(from: startDate!) + " - " + Formatters.timeWithAMPMFormatter.string(from: endDate!)
                }
            } else if let startString = eventInfo.startTime {
                let startDate = Formatters.scheduleDateFormatter.date(from: startString)
                timeString = Formatters.timeWithAMPMFormatter.string(from: startDate!)
            }
            
            if roomNameString.isEmpty {
                cell.detailTextLabel?.text = timeString
            } else {
                cell.detailTextLabel?.text = timeString + " - " + roomNameString
            }
        }
        
        return cell
    }
}
