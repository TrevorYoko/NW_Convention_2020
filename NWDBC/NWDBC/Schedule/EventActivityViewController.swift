//
//  EventActivityViewController.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/13/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import UIKit

class EventActivityViewController: UITableViewController {
    
    var eventInfo: EventInfo!
    let roomManager = EventRoomsManager.sharedInstance
    let speakerManager = SpeakerManager.sharedInstance
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(eventInfo: EventInfo) {
        self.init(nibName: nil, bundle: nil)
        
        self.eventInfo = eventInfo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView.init()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.register(DisclosureTableViewCell.self, forCellReuseIdentifier: "DisclosureCell")
        self.tableView.register(ScheduleSpeakerTableViewCell.self, forCellReuseIdentifier: "ProfileCell")
        self.tableView.register(HotelMapTableViewCell.self, forCellReuseIdentifier: "MapCell")

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfSpeakers = self.eventInfo.speakerIds != nil ? self.eventInfo.speakerIds!.count : 0
        let service = self.eventInfo.type == 2 ? 1 : 0
        return 3 + service + numberOfSpeakers
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let hasSpeakers = self.eventInfo.speakerIds != nil && (self.eventInfo.speakerIds?.count)! > 0
        
        var sanitizedRow = indexPath.row
        if sanitizedRow > 0 && self.eventInfo.type != 2 {
            sanitizedRow += 1
        }
        
        if sanitizedRow == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.attributedText = self.formatMainString()
            cell.selectionStyle = .none
            return cell
        } else if sanitizedRow == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DisclosureCell") as! DisclosureTableViewCell
            cell.textLabel?.text = "Program"
            cell.showCustomAccessory(shouldShow: true)
            return cell
        } else if hasSpeakers && (sanitizedRow - 2) >= 0 && (sanitizedRow - 2) < (self.eventInfo.speakerIds?.count)!  {
            let speakerNumber = sanitizedRow - 2
            if speakerNumber <= self.eventInfo.speakerIds!.count - 1 {
                let speakerInfo = self.speakerManager.speakerWithId(self.eventInfo.speakerIds![speakerNumber])
                if speakerInfo != nil {
                    let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ScheduleSpeakerTableViewCell
                    profileCell.setupViewWithSpeakerInfo(speakerInfo!)
                    return profileCell
                }
            }
        } else {
            let numberOfSpeakers = hasSpeakers ? (self.eventInfo.speakerIds?.count)! : 0
            sanitizedRow = sanitizedRow - numberOfSpeakers
            if sanitizedRow == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                if let roomIds = eventInfo.roomIds {
                    var roomNameString = ""
                    
                    for i in 0..<roomIds.count {
                        roomNameString.append(self.roomManager.getRoomNameWithId(roomIds[i]))
                        if i < roomIds.count - 1 {
                            roomNameString.append("/")
                        }
                    }
                    
                    
                    cell.textLabel?.text = roomNameString
                    cell.textLabel?.numberOfLines = 0
                    cell.selectionStyle = .none
                }
                return cell
            } else if sanitizedRow == 3 {
                if let roomIds = eventInfo.roomIds {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! HotelMapTableViewCell
                    //cell.centerMap(atX: 850, atY: 530)
                    return cell
                }
            }
        }
        
        return UITableViewCell.init()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let hasSpeakers = self.eventInfo.speakerIds != nil && (self.eventInfo.speakerIds?.count)! > 0
        
        var sanitizedRow = indexPath.row
        if sanitizedRow > 0 && self.eventInfo.type != 2 {
            sanitizedRow += 1
        }
        
        if sanitizedRow == 0 {
            // Do Nothing
        } else if sanitizedRow == 1 {
            if eventInfo.id == 4 {
                //Wednesday Service
                self.navigationController?.pushViewController(BCAMinistrersServiceViewController.init(), animated: true)
            } else if eventInfo.id == 10{
                //Thursday Service
                self.navigationController?.pushViewController(BCAMinistrersMorningServiceViewController.init(), animated: true)
            } else if eventInfo.id == 23{
                //Friday Service
                self.navigationController?.pushViewController(BCANCOpeningServiceViewController.init(), animated: true)
            } else if eventInfo.id == 44{
                //Closing service
                self.navigationController?.pushViewController(ClosingServiceViewController.init(), animated: true)
            }
        } else if hasSpeakers && (sanitizedRow - 2) >= 0 && (sanitizedRow - 2) < (self.eventInfo.speakerIds?.count)!  {
            let speakerNumber = sanitizedRow - 2
            if speakerNumber <= self.eventInfo.speakerIds!.count - 1 {
                let speakerInfo = self.speakerManager.speakerWithId(self.eventInfo.speakerIds![speakerNumber])
                if speakerInfo != nil {
                    let vc = ProfileViewController.init(speakerInfo: speakerInfo!)
                    vc.title = "Workshop Speaker"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else {
            let numberOfSpeakers = hasSpeakers ? (self.eventInfo.speakerIds?.count)! : 0
            sanitizedRow = sanitizedRow - numberOfSpeakers
            if sanitizedRow == 2 {
                // Do Nothing
            } else if sanitizedRow == 3 {
                self.navigationController?.pushViewController(HotelMapViewController.init(), animated: true)
            }
        }
    }
    
    private func formatMainString() -> NSAttributedString {
        let eventTitle = self.eventInfo.title
        let eventTime: String?
        if let startString = eventInfo.startTime, let endString = eventInfo.endTime {
            let timeString: String!
            let startDate = Formatters.scheduleDateFormatter.date(from: startString)
            let endDate = Formatters.scheduleDateFormatter.date(from: endString)
            
            let startAMPM = Formatters.ampmFormatter.string(from: startDate!)
            let endAMPM = Formatters.ampmFormatter.string(from: endDate!)
            
            if startAMPM == endAMPM {
                timeString = Formatters.dayOfWeekMonthDayTimeFormatter.string(from: startDate!) + " - " + Formatters.timeWithAMPMFormatter.string(from: endDate!)
            } else {
                timeString = Formatters.dayOfWeekMonthDayTimeFormatter.string(from: startDate!) + " - " + Formatters.timeWithAMPMFormatter.string(from: endDate!)
            }
            eventTime = timeString
        } else if let startString = eventInfo.startTime {
            let startDate = Formatters.scheduleDateFormatter.date(from: startString)
            let timeString = Formatters.timeWithAMPMFormatter.string(from: startDate!)
            eventTime = timeString
        } else {
            eventTime = nil
        }
        
        let eventDescription = eventInfo.description
        
        let attributedString = NSMutableAttributedString.init()
        
        if eventTitle != nil {
            let attributedEventTitle = NSMutableAttributedString.init(string: eventTitle!)
            attributedEventTitle.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 22), range: NSRange.init(location: 0, length: eventTitle!.count))
            attributedString.append(attributedEventTitle)
        }
        
        if eventTime != nil {
            let attributedEventTime = NSMutableAttributedString.init(string: eventTime!)
            attributedEventTime.addAttribute(.font, value: UIFont.systemFont(ofSize: 12), range: NSRange.init(location: 0, length: eventTime!.count))
            attributedEventTime.addAttribute(.foregroundColor, value: UIColor.lightGray, range: NSRange.init(location: 0, length: eventTime!.count))
            attributedString.append(NSMutableAttributedString.init(string: "\n"))
            attributedString.append(attributedEventTime)
        }
        
        if eventDescription != nil {
            let attributedEventDescription = NSMutableAttributedString.init(string: eventDescription!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)])
            attributedString.append(NSMutableAttributedString.init(string: "\n"))
            attributedString.append(attributedEventDescription)
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.paragraphSpacing = 5
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: attributedString.string.count))
        
        return attributedString
    }
}
