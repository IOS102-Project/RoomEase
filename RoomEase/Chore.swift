//
//  Chore.swift
//  RoomEase
//
//  Created by Josh on 11/12/25.
//

import Foundation

struct Chore: Hashable,Identifiable, Codable {
    let id: String
    var name: String
    var isCompleted: Bool
    var days: [String]

    
    init(id: String = UUID().uuidString, name: String, isCompleted: Bool = false, days: [String] = []) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
        self.days = days
    }
}
