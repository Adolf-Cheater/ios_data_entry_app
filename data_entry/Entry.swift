//
//  Entry.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-19.
//

import Foundation

struct Entry: Identifiable {
    let id = UUID()
    var userName: String
    var items: [(description: String, value: String)]
    var timestamp: String
}
