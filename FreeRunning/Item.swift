//
//  Item.swift
//  FreeRunning
//
//  Created by Naziyok, Tolga on 29.10.23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
