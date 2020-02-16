//
//  ServiceScheduleViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 11/25/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class ServiceScheduleViewController: UITableViewController {
    
    let eventManager = EventManager.sharedInstance
    let roomManager = EventRoomsManager.sharedInstance
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.title = "Services"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.tableView.tableFooterView = UIView.init()
        
        self.eventManager.applyServiceFilter()
        
        self.tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.eventManager.numberOfGroups()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventManager.numberOfEventsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let date = self.eventManager.dateForSection(section) {
            let dateString = Formatters.dayTimeFormatter.string(from: date)
            return dateString.uppercased()
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let eventInfo = self.eventManager.getEventAtIndexPath(indexPath) else { return }
        self.navigationController?.pushViewController(EventActivityViewController.init(eventInfo: eventInfo), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ScheduleTableViewCell
        
        guard let eventInfo = self.eventManager.getEventAtIndexPath(indexPath) else {return cell}
        cell.textLabel?.text = eventInfo.title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.separatorInset = UIEdgeInsets.zero
        
        cell.setColor(color: UIColor.init(red: 131/255, green: 194/255, blue: 233/255, alpha: 1.0))
        
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

