//
//  RoomManager.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/13/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

class EventRoomsManager {
    
    var eventRooms: Dictionary<Int, RoomInfo> = Dictionary.init()
    
    public static let sharedInstance = EventRoomsManager.init()
    
    init() {
        refreshEventRooms()
    }
    
    func getRoomNameWithId(_ roomId: Int) -> String {
        if let roomInfo = self.eventRooms[roomId] {
            return roomInfo.name!
        }
        
        return ""
    }
    
    private func refreshEventRooms() {
        NetworkManager.getEventRooms { (rooms) -> (Void) in
            self.eventRooms.removeAll()
            if let roomInfos = rooms {
                for roomInfo in roomInfos {
                    self.eventRooms[roomInfo.id!] = roomInfo
                }
            }
        }
    }
}
