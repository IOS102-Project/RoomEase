//
//  ShoppingListView.swift
//  RoomEase
//
//  Main Shopping List Screen with Pending/Bought tabs
//  Created by Carlos Sac on 11/15/25.
//

import SwiftUI

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @State private var showingAddItemSheet = false
    @State private var selectedTab: ShoppingListTab = .pending
    
    enum ShoppingListTab {
        case pending, bought
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Custom Tab Selector
                HStack(spacing: 0) {
                    TabButton(
                        title: "Pending",
                        isSelected: selectedTab == .pending,
                        action: { selectedTab = .pending }
                    )
                    
                    TabButton(
                        title: "Bought",
                        isSelected: selectedTab == .bought,
                        action: { selectedTab = .bought }
                    )
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Divider()
                
                // Content based on selected tab
                if selectedTab == .pending {
                    PendingItemsList(viewModel: viewModel)
                } else {
                    BoughtItemsList(viewModel: viewModel)
                }
            }
            .navigationTitle("Shopping List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddItemSheet = true }) {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingAddItemSheet) {
                AddItemSheet(viewModel: viewModel)
            }
        }
    }
}

// MARK: - Tab Button Component
struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: isSelected ? .semibold : .regular))
                    .foregroundColor(isSelected ? .blue : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                
                Rectangle()
                    .fill(isSelected ? Color.blue : Color.clear)
                    .frame(height: 2)
            }
        }
    }
}

// MARK: - Pending Items List
struct PendingItemsList: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        if viewModel.pendingItems.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "cart")
                    .font(.system(size: 60))
                    .foregroundColor(.gray.opacity(0.5))
                
                Text("No pending items")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Tap + to add items to your shopping list")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
        } else {
            List {
                ForEach(viewModel.pendingItems) { item in
                    PendingItemRow(item: item, viewModel: viewModel)
                }
                .onDelete { offsets in
                    viewModel.deleteItem(at: offsets, from: false)
                }
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Pending Item Row
struct PendingItemRow: View {
    let item: ShoppingListItem
    @ObservedObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Text(item.name)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            Spacer()
            
            // Checkmark button
            Button(action: {
                viewModel.togglePurchaseStatus(item: item)
            }) {
                Image(systemName: item.isPurchased ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24))
                    .foregroundColor(item.isPurchased ? .green : .gray.opacity(0.3))
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Bought Items List
struct BoughtItemsList: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    
    var body: some View {
        if viewModel.purchasedItems.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 60))
                    .foregroundColor(.gray.opacity(0.5))
                
                Text("No purchased items")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Items you mark as bought will appear here")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
        } else {
            List {
                ForEach(viewModel.purchasedItems) { item in
                    BoughtItemRow(item: item)
                }
                .onDelete { offsets in
                    viewModel.deleteItem(at: offsets, from: true)
                }
            }
            .listStyle(.plain)
        }
    }
}

// MARK: - Bought Item Row
struct BoughtItemRow: View {
    let item: ShoppingListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
                .font(.system(size: 16))
                .foregroundColor(.primary)
            
            HStack {
                Text(item.addedBy)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                
                if let purchasedDate = item.purchasedDate {
                    Text("•")
                        .foregroundColor(.secondary)
                    Text(formatDate(purchasedDate))
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        return formatter.string(from: date)
    }
}

// MARK: - Add Item Sheet
struct AddItemSheet: View {
    @ObservedObject var viewModel: ShoppingListViewModel
    @Environment(\.dismiss) var dismiss
    @State private var itemName = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Item name", text: $itemName)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                    .font(.system(size: 16))
                
                Spacer()
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addItem()
                    }
                    .disabled(itemName.trimmingCharacters(in: .whitespaces).isEmpty)
                    .fontWeight(.semibold)
                }
            }
        }
    }
    
    private func addItem() {
        let trimmedName = itemName.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        
        viewModel.addItem(name: trimmedName)
        dismiss()
    }
}

// MARK: - Preview
#Preview {
    ShoppingListView()
}
