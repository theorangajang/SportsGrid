//
//  PlayerCell.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/1/24.
//

import SwiftUI

struct PlayerCell: View {
    
    var body: some View {
        VStack(spacing: .zero) {
            VStack {
                Image(systemName: "person")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, Padding.regular)
                    .padding(.vertical, Padding.regular)
            }
            HStack {
                Text("Player Name")
            }
            VStack(spacing: 10) {
                HStack {
                    Text("Points")
                    Spacer()
                    Text("10.5 ppg")
                }
                HStack {
                    Text("Assists")
                    Spacer()
                    Text("5 ppg")
                }
                HStack {
                    Text("Rebounds")
                    Spacer()
                    Text("5 ppg")
                }
            }
        }
    }
    
}

#Preview {
    PlayerCell()
}
