//
//  NetworkManager.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/12/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    public static func getScheduleEvents(successBlock: (([EventInfo]?) -> (Void))?) {
        let path = Bundle.main.path(forResource: "Events", ofType: "json")
        
        do {
            let jsonData = try Data(contentsOf: URL.init(fileURLWithPath: path!))
            
            let eventsPayload = try JSONDecoder().decode(EventPayload.self, from: jsonData)
            
            if successBlock != nil {
                successBlock!(eventsPayload.events)
            }
        } catch {
            
        }
    }
    
    public static func getEventRooms(successBlock: (([RoomInfo]?) -> (Void))?) {
        let path = Bundle.main.path(forResource: "Rooms", ofType: "json")
        
        do {
            let jsonData = try Data(contentsOf: URL.init(fileURLWithPath: path!))
            
            let roomsPayload = try JSONDecoder().decode(RoomsPayload.self, from: jsonData)
            
            if successBlock != nil {
                successBlock!(roomsPayload.rooms)
            }
        } catch {
            
        }
    }
    
    public static func getEventSpeakers(successBlock: (([SpeakerInfo]?) -> (Void))?) {
        let path = Bundle.main.path(forResource: "Ministers", ofType: "json")
        
        do {
            let jsonData = try Data(contentsOf: URL.init(fileURLWithPath: path!))
            
            let roomsPayload = try JSONDecoder().decode(SpeakersPayload.self, from: jsonData)
            
            if successBlock != nil {
                successBlock!(roomsPayload.speakers)
            }
        } catch {
            
        }
    }
    
    public static func getNews(successBlock: (([NewsInfo]?) -> (Void))?, errorBlock: (() -> (Void))?) {
        let path = Bundle.main.path(forResource: "News", ofType: "json")
        
        do {
            let jsonData = try Data(contentsOf: URL.init(fileURLWithPath: path!))
           // let jsonData = try Data(contentsOf: URL.init(string: "https://convention-app-7c7b3.firebaseapp.com/ConferenceNews.json")!)
            let roomsPayload = try JSONDecoder().decode(NewsPayload.self, from: jsonData)
            
            if successBlock != nil {
                successBlock!(roomsPayload.news)
           }
        } catch {
            if errorBlock != nil {
                errorBlock!()
            }
        }
    }
}
