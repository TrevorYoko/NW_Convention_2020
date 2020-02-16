//
//  EventInfo.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/12/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

struct EventPayload: Decodable {
    let events: [EventInfo]?
    
    enum CodingKeys: String, CodingKey {
        case events = "events"
    }
}

struct EventInfo: Decodable {
    let type: Int?
    let id: Int?
    let startTime: String?
    let endTime: String?
    let title: String?
    let roomIds: [Int]?
    let description: String?
    let speakerIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case id = "id"
        case startTime = "start"
        case endTime = "end"
        case title = "title"
        case roomIds = "roomIds"
        case description = "description"
        case speakerIds = "speakerIds"
    }
}
