//
//  PlayerSeasonGrid.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import SwiftUI
import SGBase

public struct PlayerSeasonGrid: View {
    
    @StateObject private var viewModel: PlayerSeasonViewModel
    
    private let gridItemLayout: [GridItem] = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity)),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity))
    ]
    
    public init() {
        let viewModel = PlayerSeasonViewModel(year: 2015)
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            LazyVGrid(columns: self.gridItemLayout) {
                let players = Array(zip(self.viewModel.dataState.players.indices, self.viewModel.dataState.players))
                ForEach(players, id: \.1) { index, player in
                    PlayerCell(player: player)
                        .onAppear {
                            self.viewModel.getMoreSeasons(index: index)
                        }
                }
            }
            .padding(.horizontal, Padding.regular)
        }
    }
    
}

#Preview {
    PlayerSeasonGrid()
}
