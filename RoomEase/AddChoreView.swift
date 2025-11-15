//
//  AddChoreView.swift
//  RoomEase
//
//  Created by Yaroslav on 11/15/25.
//

import SwiftUI
struct AddChoreView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var selectedDays: Set<String> = []
    
    let allDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    var onAdd: (Chore) -> Void

    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("Chore Name")) {
                    TextField("Enter chore name", text: $name)
                }
                
                
                Section(header: Text("Days")) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                        ForEach(allDays, id: \.self) { day in
                            DaySelectableButton(
                                title: day,
                                isSelected: selectedDays.contains(day)
                            ) {
                                if selectedDays.contains(day) {
                                    selectedDays.remove(day)
                                } else {
                                    selectedDays.insert(day)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }
            .navigationTitle("New Chore")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newChore = Chore(
                            name: name,
                            days: Array(selectedDays).sorted()
                        )
                        onAdd(newChore)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}


struct DaySelectableButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1.5)
                )
        }
        .buttonStyle(.plain)
    }
}
