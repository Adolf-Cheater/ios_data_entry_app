//
//  Entry.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-19.
//

import Foundation

struct Entry: Identifiable {
    let id: UUID  // Using UUID to ensure each entry has a unique identifier
    var userName: String
    var items: [(description: String, value: String)]
    var timestamp: String

    init(userName: String, items: [(description: String, value: String)], timestamp: String) {
        self.id = UUID()  // Automatically generate a new UUID
        self.userName = userName
        self.items = items
        self.timestamp = timestamp
    }
}
