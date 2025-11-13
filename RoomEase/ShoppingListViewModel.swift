//
//  ShoppingListViewModel.swift
//  RoomEase
//
//  ViewModel for managing shopping list items
//

import Foundation
import Combine

class ShoppingListViewModel: ObservableObject {
    @Published var items: [ShoppingListItem] = []
    @Published var currentUserName: String = "You" // Default user name for testing
    
    // Computed properties for filtering
    var pendingItems: [ShoppingListItem] {
        items.filter { !$0.isPurchased }.sorted { $0.addedDate > $1.addedDate }
    }
    
    var purchasedItems: [ShoppingListItem] {
        items.filter { $0.isPurchased }.sorted { 
            ($0.purchasedDate ?? $0.addedDate) > ($1.purchasedDate ?? $1.addedDate)
        }
    }
    
    init() {
        // Load sample data for testing
        loadSampleData()
    }
    
    // MARK: - Public Methods
    
    func addItem(name: String) {
        let newItem = ShoppingListItem(
            name: name,
            addedBy: currentUserName
        )
        items.append(newItem)
        saveItems()
    }
    
    func togglePurchaseStatus(item: ShoppingListItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isPurchased.toggle()
            items[index].purchasedDate = items[index].isPurchased ? Date() : nil
            saveItems()
        }
    }
    
    func deleteItem(at offsets: IndexSet, from isPurchased: Bool) {
        let itemsToDelete = isPurchased ? purchasedItems : pendingItems
        offsets.forEach { index in
            if let itemIndex = items.firstIndex(where: { $0.id == itemsToDelete[index].id }) {
                items.remove(at: itemIndex)
            }
        }
        saveItems()
    }
    
    // MARK: - Private Methods
    
    private func saveItems() {
        // For now, just save to UserDefaults
        // In production, this would sync to Firebase/Backend
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "shoppingListItems")
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: "shoppingListItems"),
           let decoded = try? JSONDecoder().decode([ShoppingListItem].self, from: data) {
            items = decoded
        }
    }
    
    private func loadSampleData() {
        // Sample data for testing
        items = [
            ShoppingListItem(name: "Paper Towels", addedBy: "John", addedDate: Date().addingTimeInterval(-86400 * 2)),
            ShoppingListItem(name: "Cheese", addedBy: "Sarah", addedDate: Date().addingTimeInterval(-86400)),
            ShoppingListItem(name: "Milk", addedBy: currentUserName, addedDate: Date()),
            ShoppingListItem(
                name: "Drinks",
                isPurchased: true,
                addedBy: "June",
                purchasedDate: Date().addingTimeInterval(-86400 * 5),
                addedDate: Date().addingTimeInterval(-86400 * 6)
            ),
            ShoppingListItem(
                name: "Fruit",
                isPurchased: true,
                addedBy: currentUserName,
                purchasedDate: Date().addingTimeInterval(-86400),
                addedDate: Date().addingTimeInterval(-86400 * 2)
            )
        ]
    }
}
