//
//  HomeView.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import Matchup
import SGBase
import Season
import SwiftUI
import ThemeKit

struct HomeView: View {
    
    var body: some View {
        TabView {
            Group {
                MatchupList()
                    .tabItem {
                        Label("Matchups", systemImage: "list.bullet")
                    }
                    .tag("matchup")
                PlayerSeasonGrid()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                    .tag("search")
            }
            .toolbarBackground(Theme.Colors.lightestGrey, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
    
}

#Preview {
    HomeView()
}
