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
        GeometryReader { proxy in
            ScrollView {
                LazyVGrid(columns: self.gridItemLayout) {
                    ForEach(self.viewModel.dataState.players, id: \.id) { element in
                        PlayerCell()
                    }
                }
                .padding(.horizontal, Padding.regular)
            }
        }
    }
}

#Preview {
    ContentView(year: 2015)
}

final class ContentViewModel: ObservableObject {
    
    private let itemsFromEndThreshold = 30
    
    private let totalItemsAvailable: Int?
    private let itemsLoadedCount: Int?
    
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
    
    init(year: Int, repo: SeasonRepository = SeasonRepositoryImpl()) {
        self.repo = repo
        self.year = year
        self.totalItemsAvailable = 0
        self.itemsLoadedCount = 0
        getInitialSeason()
    }
    
    func getInitialSeason() {
        self.viewState.dataIsLoading = true
        getSeason(page: self.viewState.page)
    }
    
    func getSeason(page: Int) {
        Task {
            let season = try await self.repo.getSeason(year: self.year, page: page)
            self.dataState.players = season.players
        }
    }
    
}
