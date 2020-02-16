//
//  NewsInfo.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 2/2/19.
//  Copyright © 2019 Curtis Yamanaka. All rights reserved.
//

import Foundation

struct NewsPayload: Decodable {
    let news: [NewsInfo]?
    
    enum CodingKeys: String, CodingKey {
        case news = "events"
    }
}

struct NewsInfo: Decodable {
    let timestamp: String?
    let title: String?
    let description: String?
    let images: [String]?
    let link: NewsLink?
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp"
        case title = "title"
        case description = "description"
        case images = "images"
        case link = "link"
    }
}

struct NewsLink: Decodable {
    let title: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "url"
    }
}
