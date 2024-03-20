//
//  MainView.swift
//  SportsGrid
//
//  Created by Alex Jang on 2/15/24.
//

import SwiftUI
import SGBase
import Matchup
import Season

struct MainView: View {
    
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
    MainView()
}
