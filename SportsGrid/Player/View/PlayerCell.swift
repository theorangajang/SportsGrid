//
//  PlayerCell.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/1/24.
//

import SwiftUI

struct PlayerCell: View, Equatable {
    
    private let player: Player
    
    init(player: Player) {
        self.player = player
    }
    
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
                Text(self.player.name)
                Text("Team Image")
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, Padding.small)
            VStack(spacing: 10) {
                HStack {
                    Text("Total Points")
                    Spacer()
                    Text("\(self.player.points)")
                }
                HStack {
                    Text("Total Assists")
                    Spacer()
                    Text("\(self.player.assists)")
                }
                HStack {
                    Text("Total Rebounds")
                    Spacer()
                    Text("\(self.player.totalRebs)")
                }
            }
        }
    }
    
}

#Preview {
    PlayerCell(
        player: Player(
            id: 1,
            name: "Tarik Black",
            team: "Hou",
            points: 10,
            totalRebs: 10,
            assists: 10
        )
    )
}
