//
//  Bill.swift
//  RoomEase
//
//  Created by Josh on 11/12/25.
//

import Foundation
import SwiftUI

struct Bill: Identifiable, Codable {
    let id: String
    var name: String
    var amount: Double
    var dueDate: Date
    var status: BillStatus
    
    init(id: String = UUID().uuidString, name: String, amount: Double, dueDate: Date, status: BillStatus) {
        self.id = id
        self.name = name
        self.amount = amount
        self.dueDate = dueDate
        self.status = status
    }
    
    // Formatted date string based on wireframe
    var dueDateString: String {
        let formatter = DateFormatter()
        
        // Check if it's current month
        let calendar = Calendar.current
        if calendar.isDate(dueDate, equalTo: Date(), toGranularity: .month) {
            formatter.dateFormat = "MMM d"
            return formatter.string(from: dueDate)
        } else {
            formatter.dateFormat = "M/d"
            return formatter.string(from: dueDate)
        }
    }
}

enum BillStatus: String, Codable {
    case paid
    case pending
    case pastDue = "past due"
    
    var color: Color {
        switch self {
        case .paid: return .green
        case .pending: return .orange
        case .pastDue: return .red
        }
    }
}