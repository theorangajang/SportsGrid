//
//  MatchupListViewModel.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Combine
import Foundation

final class MatchupListViewModel: ObservableObject {
    
    struct State {
        
        var gameOdds: [GameOdds] = []
        
    }
    
    @Published var state: State
    
    private let getOddsUseCase: GetOddsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getOddsUseCase: GetOddsUseCase = .default) {
        self.state = State()
        self.getOddsUseCase = getOddsUseCase
    }
    
    func fetchGames() async {
        do {
            let gameOdds = try await self.getOddsUseCase.execute(date: .now)
            Task { @MainActor in
                self.state.gameOdds = gameOdds
            }
        } catch {
            Task { @MainActor in
                // TODO: Present an alert when failure occurs
            }
        }
    }
    
}
