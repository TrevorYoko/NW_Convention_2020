//
//  RoomInfo.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/13/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

struct RoomsPayload: Decodable {
    let rooms: [RoomInfo]?
    
    enum CodingKeys: String, CodingKey {
        case rooms = "rooms"
    }
}

struct RoomInfo: Decodable {
    let id: Int?
    let name: String?
    let centerX: Int?
    let centerY: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case centerX = "centerX"
        case centerY = "centerY"
    }
}
