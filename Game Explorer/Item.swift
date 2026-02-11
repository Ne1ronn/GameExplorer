//
//  Item.swift
//  Game Explorer
//
//  Created by Yesset on 11.02.2026.
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
