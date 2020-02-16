//
//  SpeakerInfo.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/14/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

struct SpeakersPayload: Decodable {
    let speakers: [SpeakerInfo]?
    
    enum CodingKeys: String, CodingKey {
        case speakers = "people"
    }
}

struct SpeakerFacts: Decodable {
    let title: String!
    let description: String!
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
    }
}

struct SpeakerInfo: Decodable {
    let id: Int?
    let name: String?
    let image: String?
    let secondaryImage: String?
    let title: String?
    let birthplace: String?
    let background: String?
    let temple: String?
    let facts: [SpeakerFacts]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case image = "image"
        case secondaryImage = "secondary_image"
        case title = "title"
        case birthplace = "birthplace"
        case background = "background"
        case temple = "temple"
        case facts = "facts"
    }
}
