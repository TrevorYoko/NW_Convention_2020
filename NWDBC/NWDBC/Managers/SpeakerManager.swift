//
//  SpeakerManager.swift
//  NWDBC
//
//  Created by Curtis Yamanaka on 9/14/18.
//  Copyright © 2018 Curtis Yamanaka. All rights reserved.
//

import Foundation

class SpeakerManager {
    
    var eventSpeakers: Dictionary<Int, SpeakerInfo> = Dictionary.init()
    var eventSpeakerOrder: [Int] = Array.init()
    
    public static let sharedInstance = SpeakerManager.init()
    
    init() {
        refreshSpeakers()
    }
    
    func numberOfSpeakers() -> Int {
        return self.eventSpeakers.count
    }
    
    func speakerInfoAtIndex(_ index: Int) -> SpeakerInfo? {
        if index >= eventSpeakerOrder.count {
            return nil
        }
        
        return self.eventSpeakers[eventSpeakerOrder[index]]
    }
    
    func speakerWithId(_ id: Int) -> SpeakerInfo? {
        return self.eventSpeakers[id]
    }
    
    private func refreshSpeakers() {
        NetworkManager.getEventSpeakers { (speakers) -> (Void) in
            self.eventSpeakers.removeAll()
            self.eventSpeakerOrder.removeAll()
            if let eventSpeakers = speakers {
                for speaker in eventSpeakers {
                    self.eventSpeakers[speaker.id!] = speaker
                    self.eventSpeakerOrder.append(speaker.id!)
                }
            }
        }
    }
}
