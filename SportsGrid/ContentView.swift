//
//  ContentView.swift
//  SportsGrid
//
//  Created by Alex Jang on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel: ContentViewModel
    
    private let gridItemLayout: [GridItem] = [
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity)),
        GridItem(.adaptive(minimum: .infinity, maximum: .infinity))
    ]
    
    init(year: Int) {
        let viewModel = ContentViewModel(year: 2015)
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
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
    ContentView(year: 2015)
}

import Combine

final class ContentViewModel: ObservableObject {
    
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
        getSeason()
    }
    
    func getMoreSeasons(index: Int) {
        guard let itemsLoadedCount, let totalItemsAvailable else { return }
        
        if reachedThreshold(itemsLoaded: itemsLoadedCount, index: index)
            && moreItemsRemaining(itemsLoaded: itemsLoadedCount, totalItemsAvailable: totalItemsAvailable) {
            self.viewState.page += 1
            getSeason()
        }
    }
    
    func reachedThreshold(itemsLoaded: Int, index: Int) -> Bool {
        return itemsLoaded - index == self.itemsFromEndThreshold
    }
    
    func moreItemsRemaining(itemsLoaded: Int, totalItemsAvailable: Int) -> Bool {
        return itemsLoaded < totalItemsAvailable
    }
    
    func getSeason() {
        self.viewState.dataIsLoading = true
        self.repo.getSeason(year: self.year, page: self.viewState.page)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let strongSelf = self else { return }
                    strongSelf.viewState.dataIsLoading = false
                },
                receiveValue: { [weak self] season in
                    guard let strongSelf = self else { return }
                    strongSelf.totalItemsAvailable = season.totalPlayers
                    strongSelf.dataState.players.append(contentsOf: season.players)
                    strongSelf.itemsLoadedCount = strongSelf.dataState.players.count
                }
            )
            .store(in: &self.cancellables)
    }
    
}
