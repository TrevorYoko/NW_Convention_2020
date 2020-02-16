//
//  EventsManager.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/12/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

class EventManager {
    
    var events: [EventInfo]?
    var groupedEvents: Dictionary<String, [EventInfo]>?
    
    public static let sharedInstance = EventManager.init()
    
    init() {
        refreshEvents()
        applyNoFilter()
    }
    
    func numberOfEventsInSection(_ sectionIndex: Int) -> Int {
        guard let groupedEvents = self.groupedEvents else { return 0 }
        if sectionIndex >= groupedEvents.count {
            return 0
        }
        let keys = Array(groupedEvents.keys).sorted()
        return (groupedEvents[keys[sectionIndex]]?.count)!
    }
    
    func dateForSection(_ sectionIndex: Int) -> Date? {
        guard let groupedEvents = self.groupedEvents else { return nil }
        if sectionIndex >= groupedEvents.count {
            return nil
        }
        let keys = Array(groupedEvents.keys).sorted()
        return  Formatters.scheduleDateFormatter.date(from: keys[sectionIndex])
    }
    
    func numberOfGroups() -> Int {
        guard let groupedEvents = self.groupedEvents else { return 0 }
        
        return groupedEvents.count
    }
    
    func getEventAtIndexPath(_ indexPath: IndexPath) -> EventInfo? {
        guard let groupedEvents = self.groupedEvents else { return nil }
        if indexPath.section >= groupedEvents.count {
            return nil
        }
        
        let keys = Array(groupedEvents.keys).sorted()
        guard let events = groupedEvents[keys[indexPath.section]] else { return nil }
        if indexPath.row >= events.count {
            return nil
        }
        
        return events[indexPath.row]
    }
    
    func applyNoFilter() {
        if let eventInfos = self.events {
            self.groupedEvents = Dictionary(grouping: eventInfos, by: { $0.startTime! })
        }
    }
    
    func applyActivityFilter() {
        if let eventInfos = self.events {
            let workshops = eventInfos.filter { (event) -> Bool in
                return event.type == 1
            }
            self.groupedEvents = Dictionary(grouping: workshops, by: { $0.startTime! })
        }
    }
    
    func applyWorkshopFilter() {
        if let eventInfos = self.events {
            let workshops = eventInfos.filter { (event) -> Bool in
                return event.type == 3
            }
            self.groupedEvents = Dictionary(grouping: workshops, by: { $0.startTime! })
        }
    }
    
    func applyServiceFilter() {
        if let eventInfos = self.events {
            let workshops = eventInfos.filter { (event) -> Bool in
                return event.type == 2 || event.type == 6
            }
            self.groupedEvents = Dictionary(grouping: workshops, by: { $0.startTime! })
        }
    }
    
    private func refreshEvents() {
        NetworkManager.getScheduleEvents { (events) -> (Void) in
            self.events = events
        }
    }
}
