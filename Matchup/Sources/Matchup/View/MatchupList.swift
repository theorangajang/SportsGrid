//
//  MatchupList.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import SwiftUI

public struct MatchupList: View {
    
    @StateObject private var viewModel: MatchupListViewModel
    
    public init() {
        self._viewModel = .init(wrappedValue: MatchupListViewModel())
    }
    
    public var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.viewModel.state.gameOdds, id: \.self) { games in
                    GameOddsRow(oddsItem: games)
                }
            }
        }
    }
    
}
