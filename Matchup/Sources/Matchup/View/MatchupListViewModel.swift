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
        fetchGames()
    }
    
    private func fetchGames() {
        self.getOddsUseCase.execute(date: .now)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    
                },
                receiveValue: { [weak self] gameOdds in
                    guard let strongSelf = self else { return }
                    strongSelf.state.gameOdds = gameOdds
                }
            )
            .store(in: &self.cancellables)
    }
    
}
