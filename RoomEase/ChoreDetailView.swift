//
//  ChoreDetailView.swift
//  RoomEase
//
//  Created by Yaroslav on 11/15/25.
//

import SwiftUI

struct ChoreDetailView: View {
    let chore: Chore
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Chore Details")
                        .font(.headline)
                    
                    VStack {
                        detailRow(label: "Name", value: chore.name)
                        Divider()
                        detailRow(label: "Completed", value: chore.isCompleted ? "Yes" : "No")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 2)
                    )
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Days")
                        .font(.headline)

                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(chore.days, id: \.self) { day in
                            HStack {
                                Text(day)
                                Spacer()
                            }
                            .padding(.vertical, 10)
                            
                            if day != chore.days.last {
                                Divider()
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                            .shadow(radius: 2)
                    )
                }
            }
            .padding()
        }
        .navigationTitle(chore.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func detailRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value).foregroundColor(.secondary)
        }
    }
}
