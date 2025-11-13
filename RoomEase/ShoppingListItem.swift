//
//  ShoppingListItem.swift
//  RoomEase
//
//  Shopping List Data Model
//

import Foundation

struct ShoppingListItem: Identifiable, Codable {
    let id: String
    var name: String
    var isPurchased: Bool
    var addedBy: String // User name who added the item
    var purchasedDate: Date? // When item was purchased
    var addedDate: Date
    
    init(id: String = UUID().uuidString, 
         name: String, 
         isPurchased: Bool = false, 
         addedBy: String,
         purchasedDate: Date? = nil,
         addedDate: Date = Date()) {
        self.id = id
        self.name = name
        self.isPurchased = isPurchased
        self.addedBy = addedBy
        self.purchasedDate = purchasedDate
        self.addedDate = addedDate
    }
}
