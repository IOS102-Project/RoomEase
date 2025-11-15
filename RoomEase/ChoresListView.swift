//
//  ChoresListView.swift
//  RoomEase
//
//  Created by Josh on 11/12/25.
//  Reviewed by Carlos Sac on 11/15/25.
//

import SwiftUI

struct ChoresListView: View {
    @State private var chores: [Chore] = []
    @State private var showingAddChore = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(chores) { chore in
                    ChoreRowView(chore: chore)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Chores")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddChore = true }) {
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                    }
                }
            }
            .onAppear {
                loadChores()
            }
        }
    }
    
    private func loadChores() {
        chores = [
            Chore(name: "Dishes"),
            Chore(name: "Trash"),
            Chore(name: "Laundry")
        ]
    }
}

// MARK: - Chore Row Component
struct ChoreRowView: View {
    let chore: Chore
    
    var body: some View {
        HStack {
            Text(chore.name)
                .font(.system(size: 17))
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ChoresListView()
}
