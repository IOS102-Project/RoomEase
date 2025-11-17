//
//  LaunchView.swift
//  RoomEase
//
//  Created by june taylr on 11/16/25.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        ZStack {
            Image("roomease")
                .resizable()
                .scaledToFit()
                .frame(width: 700, height: 700)
        }
    }
}

#Preview {
    LaunchView()
}
