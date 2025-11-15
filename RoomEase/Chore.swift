//
//  Chore.swift
//  RoomEase
//
//  Created by Josh on 11/12/25.
//

import Foundation

struct Chore: Identifiable, Codable {
    let id: String
    var name: String
    var isCompleted: Bool
    
    init(id: String = UUID().uuidString, name: String, isCompleted: Bool = false) {
        self.id = id
        self.name = name
        self.isCompleted = isCompleted
    }
}