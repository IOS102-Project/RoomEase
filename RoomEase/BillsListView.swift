//
//  BillsListView.swift
//  RoomEase
//
//  Created by Josh on 11/12/25.
//

import SwiftUI

struct BillsListView: View {
    @State private var bills: [Bill] = []
    @State private var showingAddBill = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(bills) { bill in
                    BillRowView(bill: bill)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Bills")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddBill = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                loadBills()
            }
        }
    }
    
    private func loadBills() {
        // Sample data matching your wireframe
        let calendar = Calendar.current
        let now = Date()
        
        // Rent - 11/01 (paid)
        let rentDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 1))!
        
        // Water - Nov 16 (pending)
        let waterDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 16))!
        
        // Gas - Nov 10 (past due)
        let gasDate = calendar.date(from: DateComponents(year: 2025, month: 11, day: 10))!
        
        bills = [
            Bill(name: "Rent", amount: 3000.00, dueDate: rentDate, status: .paid),
            Bill(name: "Water", amount: 45.98, dueDate: waterDate, status: .pending),
            Bill(name: "Gas", amount: 37.50, dueDate: gasDate, status: .pastDue)
        ]
    }
}

// MARK: - Bill Row Component
struct BillRowView: View {
    let bill: Bill
    
    var body: some View {
        HStack {
            // Bill name
            Text(bill.name)
                .font(.system(size: 17))
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                // Amount
                Text("$\(bill.amount, specifier: "%.2f")")
                    .font(.system(size: 17))
                    .fontWeight(.regular)
                
                // Due date and status
                HStack(spacing: 4) {
                    Text(bill.dueDateString)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text(bill.status.rawValue)
                        .font(.system(size: 13))
                        .foregroundColor(bill.status.color)
                }
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    BillsListView()
}