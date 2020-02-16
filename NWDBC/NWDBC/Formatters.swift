//
//  Formatters.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/13/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

class Formatters {
    static let scheduleDateFormatter = ISO8601DateFormatter()
    
    static let dayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EEEE h:mm a")
        return formatter
    }()
    
    static let ampmFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("a")
        return formatter
    }()
    
    static let timeWithAMPMFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("h:mm a")
        return formatter
    }()
    
    static let timeWithoutAMPMFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("h:mm")
        return formatter
    }()
    
    static let dayOfWeekMonthDayTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d, h:mm")
        return formatter
    }()
    
    static let dayOfWeekMonthDayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("EEEE, MMMM d")
        return formatter
    }()
}
