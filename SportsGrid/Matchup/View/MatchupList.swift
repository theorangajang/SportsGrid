//
//  MatchupList.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import SwiftUI

struct MatchupList: View {
    
    @StateObject private var viewModel: MatchupListViewModel
    
    init() {
        self._viewModel = .init(wrappedValue: MatchupListViewModel())
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(self.viewModel.state.gameOdds, id: \.self) { games in
                    GameOddsRow(oddsItem: games)
                }
            }
        }
    }
    
}
