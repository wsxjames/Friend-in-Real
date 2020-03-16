//
//  Event.swift
//  Friend in Real
//
//  Created by 吴世欣 on 3/14/20.
//  Copyright © 2020 James Wu. All rights reserved.
//

import Foundation

class Event{
    var location: Array<Double>
    var initiator: String
    var participants: Array<String>
    
    init(location: Array<Double>, initiator: String, participants: Array<String>) {
        self.location=location
        self.initiator=initiator
        self.participants=participants
    }
}
