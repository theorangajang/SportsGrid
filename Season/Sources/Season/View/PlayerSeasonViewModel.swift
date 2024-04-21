//
//  PlayerSeasonViewModel.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/6/24.
//

import Foundation
import Combine

final class PlayerSeasonViewModel: ObservableObject {
    
    private let itemsFromEndThreshold = 15
    
    private var totalItemsAvailable: Int?
    private var itemsLoadedCount: Int?
    
    struct ViewState {
        
        var dataIsLoading = false
        var page = 1
        
    }
    
    struct DataState {
        
        var players = [Player]()
        
    }
    
    @Published var dataState = DataState()
    @Published var viewState = ViewState()
    
    private let repo: SeasonRepository
    private let year: Int
    
    private var cancellables = Set<AnyCancellable>()
    
    init(year: Int, repo: SeasonRepository = SeasonRepositoryImpl()) {
        self.repo = repo
        self.year = year
        Task {
            await getSeason()            
        }
    }
    
    func getMoreSeasons(index: Int) async {
        guard let itemsLoadedCount, let totalItemsAvailable else { return }
        
        if reachedThreshold(itemsLoaded: itemsLoadedCount, index: index)
            && moreItemsRemaining(itemsLoaded: itemsLoadedCount, totalItemsAvailable: totalItemsAvailable) {
            self.viewState.page += 1
            await getSeason()
        }
    }
    
    func reachedThreshold(itemsLoaded: Int, index: Int) -> Bool {
        return itemsLoaded - index == self.itemsFromEndThreshold
    }
    
    func moreItemsRemaining(itemsLoaded: Int, totalItemsAvailable: Int) -> Bool {
        return itemsLoaded < totalItemsAvailable
    }
    
    func getSeason() async {
        self.viewState.dataIsLoading = true
        do {
            let season = try await self.repo.getSeason(year: self.year, page: self.viewState.page)
            self.dataState.players.append(contentsOf: season.players)
            Task { @MainActor in
                self.totalItemsAvailable = season.totalPlayers
                self.itemsLoadedCount = self.dataState.players.count
                self.viewState.dataIsLoading = false
            }
        } catch {
            Task { @MainActor in
                self.viewState.dataIsLoading = false
            }
        }
    }
    
}

